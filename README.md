 <div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:000046,100:1CB5E0&height=250&section=header&text=GeoSeg-PointAI&fontSize=60&fontColor=ffffff&fontAlignY=40&desc=Weakly-Supervised%20Remote%20Sensing%20Segmentation&descAlignY=65&descSize=22&animation=fadeIn" width="100%">
  
  <br><br>
 
</div>

---
  <h1 align="center">🛰️GeoSeg-PointAI: Weakly-Supervised Remote Sensing Segmentation</h1>
  <p align="center">
    <strong>End-to-End Semantic Segmentation API trained on highly sparse point-level annotations using a Custom Partial Focal Loss.</strong>
  </p>
  <p align="center">
    <img src="https://img.shields.io/badge/Python-3.10+-blue.svg?style=for-the-badge&logo=python&logoColor=white" alt="Python">
    <img src="https://img.shields.io/badge/PyTorch-EE4C2C?style=for-the-badge&logo=pytorch&logoColor=white" alt="PyTorch">
    <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white" alt="Flask">
    <img src="https://img.shields.io/badge/Computer%20Vision-DeepLabV3-orange?style=for-the-badge" alt="DeepLabV3">
  </p>
</p>

---

## 🚀 The Challenge: The Point-Level Annotation Bottleneck
Training deep learning models for semantic segmentation traditionally requires exhaustive, pixel-perfect complete masks. In remote sensing, acquiring such dense annotations is cost-prohibitive. 

**The Solution?** We tackle this by training a complex `DeepLabV3 (ResNet50)` architecture using **only sparse point-level annotations** (incomplete tagging). To make the model learn effectively from limited pixels while ignoring the vast unknown regions, a custom mathematical approach was required.

---

## 🧠 Core Methodology: Custom Partial Focal Loss (pfCE)
To overcome the extreme class imbalance and the lack of dense boundary information, a custom loss function termed **Partial Focal Cross Entropy (pfCE)** was designed and implemented from scratch.

$$pfCE = \frac{\sum (Focal\_Loss(Pred, GT) \times MASK_{labeled})}{\sum MASK_{labeled} + \epsilon}$$

* **Focal Mechanism:** Focuses on hard-to-classify pixels and down-weights easy examples ($\gamma = 2.0$).
* **Masking Strategy:** Multiplies the loss by a binary `labeled_mask`, dynamically zeroing out the gradient for all unlabeled/unknown pixels.
* **Result:** The model learns structural patterns and boundaries from as few as 10 to 50 labeled points per class!

---

## 📊 Experimental Results & Simulation
The model was evaluated on the `LandCover.ai` dataset. We simulated point labels by randomly sampling from the complete ground truth masks. 

| Experiment Setup | Annotated Points / Class | Final Training Loss | True mIoU (Accuracy) |
| :--- | :---: | :---: | :---: |
| **Baseline** | 10 Points | `0.2924` | **75.11%** |
| **Improved** | 50 Points | `0.3868` | **76.31%** |

> **Conclusion:** The custom `pfCE` loss proved highly effective. Increasing the point density from 10 to 50 points yielded a "Diminishing Returns" improvement, demonstrating the model's powerful feature extraction capabilities even with minimal data.

### 👁️ Visual Comparison
*(The model successfully reconstructs complete semantic maps from sparse points!)*
 <p align="center">
  <img src="https://github.com/user-attachments/assets/5b2edcd2-f899-49d0-88b9-317ffc7ddff0" />
                                      Visual Comparison🛰
</p>
---
 

## ☁️ Cloud Deployment (Google Cloud Platform)
This project is fully containerized and deployed as a production-ready REST API on **Google Cloud Platform (GCP)**, ensuring high availability and scalability for processing large satellite imagery.

### 🌐 Live API Endpoint
> **Base URL:** `[PUT_YOUR_GOOGLE_CLOUD_URL_HERE]` *(Currently Active)*

---

## 🛠️ Installation & Setup (Flask API)

This repository includes a production-ready **Flask REST API** to serve the trained model for real-time inference.

### 1. Clone the Repository
```bash
git clone [https://github.com/YOUR_GITHUB_USERNAME/RemoteSensing-PointSeg-API.git](https://github.com/YOUR_GITHUB_USERNAME/RemoteSensing-PointSeg-API.git)
cd RemoteSensing-PointSeg-API

2. Install Dependencies
Bash
pip install -r requirements.txt
### 3. ⚠️ DOWNLOAD MODEL WEIGHTS ⚠️
Due to GitHub's file size limits, the trained PyTorch weights (model_50.pth) are hosted externally.

👉[ https://drive.google.com/file/d/1rtHIqGjgCqPsZCvq9tLBWR56bCFyOmmU/view?usp=sharing ] 👈

Instruction: Download the .pth file and place it directly in the root folder of this project.

4. Run the API Server
Bash
python app.py
The server will start locally on http://127.0.0.1:5000/

📡 API Usage
You can test the API by sending a POST request with a satellite image (.tif, .png, or .jpg).

Using cURL:

Bash
curl -X POST -F "file=@sample_image.tif" [http://127.0.0.1:5000/predict](http://127.0.0.1:5000/predict) -o output_mask.png
The API will return a fully colorized segmentation mask as a PNG image.


---

## 👨‍💻 Author

👉 **Mohamed Salama** 👨‍💻 Computer Science | AI & Data Science Enthusiast  

✨ [LinkedIn Profile](http://www.linkedin.com/in/mohammed-salamaa)  
✨ [Email Me](mailto:mohamedsalama.com77@gmail.com)  

---
