# Asset Pricing and Quantitative Portfolio Management 📈

![Grade](https://img.shields.io/badge/Grade-30%2F30-brightgreen)
![Language](https://img.shields.io/badge/Language-MATLAB-orange)
![University](https://img.shields.io/badge/University-UNIBO-red)

**Course:** Economics of Financial Markets  
**Program:** MSc in Quantitative Finance, University of Bologna (UNIBO)  
**Date:** January 2026  

## Overview
This repository contains the code and the final report for the "Economics of Financial Markets" Take-Home Exam. The project bridges advanced theoretical asset pricing models with rigorous empirical analysis and portfolio optimization on real financial data.

The project is structured into two main sections:

### 1. Empirical Analysis & Asset Allocation (MATLAB)
A comprehensive data-driven analysis of financial assets (Nasdaq and NYSE, daily and monthly frequencies). The MATLAB code implements and compares multiple advanced portfolio optimization frameworks to address estimation error and model risk:
* **Classic Markowitz Mean-Variance** optimization.
* **Black-Litterman Model** incorporating market implied returns and specific investor views.
* **Bayesian Asset Allocation** to manage uncertainty.
* **Resampled Efficient Frontier** (Michaud) for robust portfolio construction.
* **Combined Model-Averaging** strategies.

### 2. Theoretical Framework: Macroeconomic Risk & Asset Pricing
A deep-dive theoretical analysis reviewing standard consumption-based models (CRRA utility) and their failures. The report extensively explores the **Long-Run Risks (LRR)** framework:
* The foundational Bansal & Yaron (2004) model with Epstein-Zin recursive preferences.
* The extension by Miller, Paron, and Wachter (2021), focusing on the critical role of **permanent macroeconomic shocks** and sovereign default risk in explaining the secular decline in real interest rates and the flattening of the yield curve.
* Mathematical derivations of the Stochastic Discount Factor (SDF) and the affine term structure of bond yields.

## Repository Contents
* `asset_pricing_analysis.m`: The full MATLAB script containing data importing, statistical analysis, and portfolio optimization algorithms.
* `asset_pricing_report.pdf`: The final comprehensive report discussing both the empirical findings and the theoretical asset pricing derivations.

## How to Run
1. Open `asset_pricing_analysis.m` in MATLAB.
2. Run the code sequentially following the section index at the top of the file (the script is divided into parts to avoid memory overload).

## Technologies Used
* **MATLAB** (Data Analysis, Financial Toolbox, Statistics and Machine Learning Toolbox)

## Authors
* Federica Campitelli — MSc in Quantitative Finance, University of Bologna
* Martina Visotti — MSc in Quantitative Finance, University of Bologna
