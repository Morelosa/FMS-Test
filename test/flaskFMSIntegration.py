from flask import Flask, request, jsonify
import cv2
import mediapipe as mp
import numpy as np

app = Flask(__name__)

@app.route('/')
def welcome_page():
    return "Welcome to FMS Test API! Send a video file to the /process_video endpoint for processing."

def deep_squat_score(x, y, z):
    if x and y and z:
        return 3
    elif x and y and not z:
        return 2
    elif not x and not y and not z:
        return 1
    else:
        return 10

def calculate_angle(a, b, c):
    a = np.array(a)
    b =  np.array(b)
    c = np.array(c)
    
    radians = np.arctan2(c[1] - b[1], c[0] - b[0]) - np.arctan2(a[1] - b[1], a[0] - b[0])
    angle = np.abs(radians*180.0/np.pi)
    
    if angle > 180.0:
        angle = 360 - angle
    
    return angle

mp_pose = mp.solutions.pose
pose = mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5)
mp_drawing = mp.solutions.drawing_utils

def process_video(video_path):

    cap = cv2.VideoCapture(video_path)
    angles_dict = {}
    knee_distance = {}
    parallelism_angles = {}

    min_l_hip_angle = 180
    min_r_hip_angle = 180
    squat_depth = False

    starting_knee_distance = None
    knee_distance = 1
    knee_distance_threshold = .2 
    knees_caved_in = False

    min_torso_angle = 180
    min_tibia_angle = 180

    parallelism_threshold = 15
    parallel = True

    squat_score = 0

    while cap.isOpened():
        ret, frame = cap.read()
        if not ret:
            break

    try:
        # Color conversion for MediaPipe Pose model
        image = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        image.flags.writeable = False

        # Make detection using MediaPipe Pose model
        results = pose.process(image)

        image.flags.writeable = True
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

        # Extract landmarks and calculate wrist distance
        try:
            landmarks = results.pose_landmarks.landmark

            # Get coordinates
            l_shoulder = [landmarks[mp_pose.PoseLandmark.LEFT_SHOULDER.value].x, landmarks[mp_pose.PoseLandmark.LEFT_SHOULDER.value].y]
            l_hip = [landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].x, landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].y]
            l_knee = [landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].x, landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].y]
            l_ankle = [landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].x, landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].y]

            r_shoulder = [landmarks[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_SHOULDER.value].y]
            r_hip = [landmarks[mp_pose.PoseLandmark.RIGHT_HIP.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_HIP.value].y]
            r_knee = [landmarks[mp_pose.PoseLandmark.RIGHT_KNEE.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_KNEE.value].y]
            r_ankle = [landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE.value].y]

            # Calculate angles
            torso_angle = calculate_angle(l_shoulder, l_hip, l_knee)
            tibia_angle = calculate_angle(l_hip, l_knee, l_ankle)

            # Find Minimum Angle
            if torso_angle < min_torso_angle:
                min_torso_angle = torso_angle

            parallelism_angles["torso_angle"] = torso_angle

            if tibia_angle < min_tibia_angle:
                min_tibia_angle = tibia_angle

            parallelism_angles["tibia_angle"] = tibia_angle

            angle_difference = abs(tibia_angle - torso_angle)

            # Checking if torso and tibia are parallel
            if angle_difference >= parallelism_threshold:
                parallel = False

            # Calculate Hip Angle
            l_hip_angle = calculate_angle(l_shoulder, l_hip, l_knee)
            r_hip_angle = calculate_angle(r_shoulder, r_hip, r_knee)

            # Loop and breakdown into each frame and calculate hip angle
            if l_hip_angle < min_l_hip_angle:
                min_l_hip_angle = l_hip_angle

            angles_dict['min_l_hip_angle'] = min_l_hip_angle

            if r_hip_angle < min_r_hip_angle:
                min_r_hip_angle = r_hip_angle

            angles_dict['min_r_hip_angle'] = min_r_hip_angle

            # Checking if depth has been reached
            if (min_l_hip_angle + min_r_hip_angle) / 2 <= 90:
                squat_depth = True

            # Calculate Distance Between Elbows
            knee_distance = np.linalg.norm(np.array(l_knee) - np.array(r_knee))

            # Record the starting elbow distance
            if starting_knee_distance is None:
                starting_knee_distance = knee_distance

            # Take Minimum Distance Between Knees
            if knee_distance < min_knee_distance:
                min_knee_distance = knee_distance

            knee_distance['min_knee_distance'] = min_knee_distance
            knee_distance['starting_knee_distance'] = starting_knee_distance

            # Check if knees have caved in
            if (starting_knee_distance - min_knee_distance) > knee_distance_threshold:
                knees_caved_in = True

            # Visualize Angle
            cv2.putText(image, str(r_hip_angle),
                        tuple(np.multiply(r_hip, [640, 480]).astype(int)),
                        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 2, cv2.LINE_AA)

            # Render detections
            mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_pose.POSE_CONNECTIONS,
                                      mp_drawing.DrawingSpec(color=(245, 117, 66), thickness=2, circle_radius=2),
                                      mp_drawing.DrawingSpec(color=(245, 66, 230), thickness=2, circle_radius=2))

        except Exception as e:
            print(f"Error processing frame: {e}")

        # Render detections
        mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_pose.POSE_CONNECTIONS,
                                  mp_drawing.DrawingSpec(color=(245, 117, 66), thickness=2, circle_radius=2),
                                  mp_drawing.DrawingSpec(color=(245, 66, 230), thickness=2, circle_radius=2))

        cv2.imshow("Mediapipe Feed", image)

        squat_score = deep_squat_score(squat_depth, parallel, knees_caved_in)

    except Exception as e:
        print(f"Error processing frame: {e}")

    cap.release()
    return squat_score

@app.route('/process_video', methods=['POST'])
def process_video_endpoint():
    try:
        # Receive video from Flutter app
        video_data = request.files['video'].read()
        with open('uploaded_video.mp4', 'wb') as video_file:
            video_file.write(video_data)

        # Process the video
        result = process_video('uploaded_video.mp4')

        # Return the result as JSON
        return jsonify({'result': result})

    except Exception as e:
        return jsonify({'error': str(e)})

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
