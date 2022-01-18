import cv2
import sys
import os.path
from pathlib import Path

#change filepath to cascade xml file
def detect(filename, cascade_file = "lbpcascade_animeface.xml"):
    if not os.path.isfile(cascade_file):
        raise RuntimeError("%s: not found" % cascade_file)

    #change file path 
    filename = "danbooru2020\\512px\\0033\\" + filename

    cascade = cv2.CascadeClassifier(cascade_file)
    image = cv2.imread(filename, cv2.IMREAD_COLOR)
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    gray = cv2.equalizeHist(gray)
    
    faces = cascade.detectMultiScale(gray,
                                     # detector options
                                     scaleFactor = 1.1,
                                     minNeighbors = 5,
                                     minSize = (24, 24))
    for (x, y, w, h) in faces:
        cv2.rectangle(image, (x, y), (x + w, y + h), (0, 0, 0), 2)
        faces = image[y:y + h, x:x + w]
        cv2.imshow("face", faces)
        cv2.imwrite("faces\\" + Path(filename).stem + "_face.jpg", faces)

    #cv2.imshow("AnimeFaceDetect", image)
    #cv2.waitKey(0)
    #cv2.imwrite(Path(filename).stem + "_face.jpg", image)

if len(sys.argv) != 2:
    sys.stderr.write("usage: detect.py <filename>\n")
    sys.exit(-1)
    
detect(sys.argv[1])