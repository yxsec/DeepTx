# Re-import required libraries after kernel reset
import numpy as np
import pandas as pd
from statistics import mean, stdev

# Redefine corrected_metrics function
def corrected_metrics(phishing_cases, benign_cases, results_dict):
    precision_list = []
    recall_list = []
    f1_list = []

    for run in range(3):
        TP = sum([results_dict[c][run] for c in phishing_cases])
        FN = len(phishing_cases) - TP

        TN = sum([results_dict[c][run] for c in benign_cases])
        FP = len(benign_cases) - TN

        precision = TP / (TP + FP) if (TP + FP) > 0 else 0
        recall = TP / (TP + FN) if (TP + FN) > 0 else 0
        f1 = 2 * precision * recall / (precision + recall) if (precision + recall) > 0 else 0

        precision_list.append(precision)
        recall_list.append(recall)
        f1_list.append(f1)

    return {
        "Precision (mean ± std)": f"{mean(precision_list):.2f} ± {stdev(precision_list):.2f}",
        "Recall (mean ± std)": f"{mean(recall_list):.2f} ± {stdev(recall_list):.2f}",
        "F1 Score (mean ± std)": f"{mean(f1_list):.2f} ± {stdev(f1_list):.2f}"
    }

# Re-define updated data
updated_phishing_cases = [
    "airdrop-scam", "defi-proxy-phishing", "nft-approval-phishing", "safe-proxy-attack",
    "usdt-approval-phishing", "www.gevolsnfft.xyz", "www.claim-bayc.com", "tp32561.top",
    "tesla3.link", "moonbirdsclaim.xyz", "claimslp.com", "drop-eth.info"
]
updated_benign_cases = ["aave_stake", "aave_wrap"]

updated_full_results = {
    "airdrop-scam": [1, 1, 1],
    "defi-proxy-phishing": [1, 1, 1],
    "nft-approval-phishing": [1, 1, 1],
    "safe-proxy-attack": [1, 1, 1],
    "usdt-approval-phishing": [1, 1, 1],
    "www.gevolsnfft.xyz": [1, 1, 1],
    "www.claim-bayc.com": [1, 1, 1],
    "tp32561.top": [1, 1, 1],
    "tesla3.link": [1, 0, 1],
    "moonbirdsclaim.xyz": [0, 0, 0],
    "claimslp.com": [1, 1, 1],
    "drop-eth.info": [1, 1, 1],
    "aave_stake": [1, 1, 1],
    "aave_wrap": [1, 1, 1]
}

updated_no_ui_results = {
    "airdrop-scam": [0, 0, 0],
    "defi-proxy-phishing": [0, 0, 0],
    "nft-approval-phishing": [0, 0, 0],
    "safe-proxy-attack": [0, 0, 0],
    "usdt-approval-phishing": [0, 0, 0],
    "www.gevolsnfft.xyz": [1, 1, 1],
    "www.claim-bayc.com": [0, 0, 0],
    "tp32561.top": [1, 0, 1],
    "tesla3.link": [0, 0, 0],
    "moonbirdsclaim.xyz": [0, 0, 0],
    "claimslp.com": [1, 1, 1],
    "drop-eth.info": [0, 0, 0],
    "aave_stake": [1, 1, 0],
    "aave_wrap": [1, 1, 1]
}

# Calculate updated metrics
corrected_updated_full = corrected_metrics(updated_phishing_cases, updated_benign_cases, updated_full_results)
corrected_updated_no_ui = corrected_metrics(updated_phishing_cases, updated_benign_cases, updated_no_ui_results)

# Create DataFrame
corrected_updated_df = pd.DataFrame(
    [corrected_updated_full, corrected_updated_no_ui],
    index=["Full DeepTx", "No UI"]
)


print(corrected_updated_df)