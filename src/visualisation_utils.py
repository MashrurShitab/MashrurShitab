"""Simple optional plotting helpers.

The notebooks use direct plotting code with matplotlib and seaborn. This file
only keeps one small save helper for reference.
"""

import matplotlib.pyplot as plt


def save_current_plot(file_path):
    plt.tight_layout()
    plt.savefig(file_path, dpi=160)
