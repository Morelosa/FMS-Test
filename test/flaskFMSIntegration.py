from flask import Flask, request, jsonify
import cv2
import mediapipe as mp
import numpy as np

app = Flask(__name__)

@app.route('/')
def welcome_page():
    return "Welcome to FMS Test API! Send a video file to the /process_video endpoint for processing."

mp_pose = mp.solutions.pose
pose = mp_pose.Pose(min_detection_confidence=0.5, min_tracking_confidence=0.5)
mp_drawing = mp.solutions.drawing_utils

def process_video(video_path):

    cap = cv2.VideoCapture(video_path)
    min_wrist_distance = 100

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
                l_wrist = [landmarks[mp_pose.PoseLandmark.LEFT_WRIST.value].x, landmarks[mp_pose.PoseLandmark.LEFT_WRIST.value].y]
                r_wrist = [landmarks[mp_pose.PoseLandmark.RIGHT_WRIST.value].x, landmarks[mp_pose.PoseLandmark.RIGHT_WRIST.value].y]

                # Calculate Distance Between Landmarks
                wrist_distance = np.linalg.norm(np.array(l_wrist) - np.array(r_wrist))

                # Take Minimum Distance Between Wrists
                if wrist_distance < min_wrist_distance:
                    min_wrist_distance = wrist_distance

                # Draw the distance text on the frame
                cv2.putText(image, f"Wrist Distance: {wrist_distance:.2f} units",
                            tuple(np.multiply(l_wrist, [640, 480]).astype(int)),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.5, (255, 255, 255), 2, cv2.LINE_AA)

            except Exception as e:
                print(f"Error processing landmarks: {e}")

            # Render detections
            mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_pose.POSE_CONNECTIONS,
                                      mp_drawing.DrawingSpec(color=(245, 117, 66), thickness=2, circle_radius=2),
                                      mp_drawing.DrawingSpec(color=(245, 66, 230), thickness=2, circle_radius=2))

        except Exception as e:
            print(f"Error processing frame: {e}")

    cap.release()
    return min_wrist_distance



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
