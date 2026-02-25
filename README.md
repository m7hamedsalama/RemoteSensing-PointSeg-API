<p align="center">
  <img src="https://img.icons8.com/external-flatart-icons-lineal-color-flatarticons/64/000000/external-satellite-space-flatart-icons-lineal-color-flatarticons-1.png" width="80" alt="Satellite Logo">
  <h1 align="center">GeoSeg-PointAI: Weakly-Supervised Remote Sensing Segmentation</h1>
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
  <img src="<img width="1978" height="513" alt="image" src="https://github.com/user-attachments/assets/c53a3493-a923-4ff1-9e6a-f04603acac06" />
" alt="Visual Comparison Results" width="100%">
</p>

---

## 🛠️ Installation & Setup (Flask API)

This repository includes a production-ready **Flask REST API** to serve the trained model for real-time inference.

### 1. Clone the Repository
```bash
git clone [https://github.com/YOUR_GITHUB_USERNAME/RemoteSensing-PointSeg-API.git](https://github.com/YOUR_GITHUB_USERNAME/RemoteSensing-PointSeg-API.git)
cd RemoteSensing-PointSeg-API
