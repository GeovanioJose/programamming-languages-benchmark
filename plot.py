import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
from colour import Color
import seaborn as sns
import os
import warnings

# Hide visual warnings on the terminal for a clean output
warnings.filterwarnings("ignore", category=UserWarning)
warnings.filterwarnings("ignore", category=RuntimeWarning)

# Default Seaborn style
sns.set_theme(style="white")

languages = ["c", "c++", "c#", "java", "dart", "f#", "fortran", "go", "javascript", "php", "lua", "python", "ruby", "perl", "rust", "julia", "ada", "haskell", "ocaml", "swift", "racket"]
problems = ["binarytrees", "fannkuchredux", "fasta", "knucleotide", "mandelbrot", "nbody", "pidigits", "regexredux", "reversecomplement", "spectralnorm"]

# ---------------------------------------------------------------------------
# FONT CONFIGURATION
# Change BASE_FONT_SIZE (and, if needed, the offsets below) to scale every
# font used across all plots at once.
# ---------------------------------------------------------------------------
BASE_FONT_SIZE = 16

plt.rc('font', size=BASE_FONT_SIZE)
plt.rc('axes', titlesize=BASE_FONT_SIZE + 4)
plt.rc('axes', labelsize=BASE_FONT_SIZE + 2)
plt.rc('xtick', labelsize=BASE_FONT_SIZE - 1)
plt.rc('ytick', labelsize=BASE_FONT_SIZE - 1)
plt.rc('legend', fontsize=BASE_FONT_SIZE)
plt.rc('figure', titlesize=BASE_FONT_SIZE + 6)

# Figure size used for every individual plot
FIGSIZE = (12, 7)

# Path to the folders where the plots will be saved
save_path_languages = "results/plots/languages"
save_path_problems = "results/plots/problems"

# Automatically create the directories if they don't exist
os.makedirs(save_path_languages, exist_ok=True)
os.makedirs(save_path_problems, exist_ok=True)


# Utility function to prevent NaN or divide-by-zero limit errors
def aplicar_limite_seguro(df, coluna, modo='ylim', limite_padrao=100):
    val_max = df[coluna].max() if coluna in df.columns else 0
    if pd.isna(val_max) or val_max == 0:
        val_max = limite_padrao
    else:
        val_max = val_max * 1.1

    if modo == 'ylim':
        plt.ylim(0, val_max)
    else:
        plt.xlim(0, val_max)


# --- PLOTS PER LANGUAGE ---
for i in range(len(languages)):
    caminho_csv = "results/languages/{0}.csv".format(languages[i])
    if not os.path.exists(caminho_csv) or os.path.getsize(caminho_csv) == 0:
        continue

    df = pd.read_csv(caminho_csv, sep=",", header=0, encoding="utf-8")
    df = df.fillna(0)

    # Plot 1: Total Energy per Problem
    plt.figure(figsize=FIGSIZE)
    df.sort_values("avg_total", inplace=True)

    plt.ylabel("Joules")
    aplicar_limite_seguro(df, "avg_total", 'ylim', 100)

    plt.xticks(rotation=30)
    bar = plt.bar(df["problems"], df["avg_total"])

    for index, value in enumerate(df["avg_total"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')

    plt.tight_layout()
    plt.savefig(os.path.join(save_path_languages, f"{languages[i]}-total_energy.pdf"), dpi=300)
    plt.close()

    # Plot 2: Average Power
    df.sort_values("avg_watts", inplace=True)
    plt.figure(figsize=FIGSIZE)
    plt.ylabel("Watts")
    bar = plt.bar(df["problems"], df["avg_watts"])
    aplicar_limite_seguro(df, "avg_watts", 'ylim', 50)
    plt.xticks(rotation=30)
    for index, value in enumerate(df["avg_watts"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')
    plt.tight_layout()
    plt.savefig(os.path.join(save_path_languages, f"{languages[i]}-avg_power.pdf"), dpi=300)
    plt.close()

    # Plot 3: Average Max Memory
    df.sort_values("avg_max_memory", inplace=True)
    plt.figure(figsize=FIGSIZE)
    plt.ylabel("MB")
    bar = plt.bar(df["problems"], df["avg_max_memory"])
    aplicar_limite_seguro(df, "avg_max_memory", 'ylim', 1024)
    plt.xticks(rotation=30)
    for index, value in enumerate(df["avg_max_memory"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')
    plt.tight_layout()
    plt.savefig(os.path.join(save_path_languages, f"{languages[i]}-avg_max_memory.pdf"), dpi=300)
    plt.close()

    # Plot 4: Average Runtime
    df.sort_values("avg_runtime", inplace=True)
    plt.figure(figsize=FIGSIZE)
    plt.ylabel("Seconds")
    bar = plt.bar(df["problems"], df["avg_runtime"])
    aplicar_limite_seguro(df, "avg_runtime", 'ylim', 10)
    plt.xticks(rotation=30)
    for index, value in enumerate(df["avg_runtime"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')
    plt.tight_layout()
    plt.savefig(os.path.join(save_path_languages, f"{languages[i]}-avg_runtime.pdf"), dpi=300)
    plt.close()

    # Plot 5: Average CPU Temperature
    df.sort_values("avg_cpu_temp", inplace=True)
    plt.figure(figsize=FIGSIZE)
    plt.ylabel("°C")
    bar = plt.bar(df["problems"], df["avg_cpu_temp"])
    plt.ylim(0, 100)
    plt.xticks(rotation=30)
    for index, value in enumerate(df["avg_cpu_temp"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')
    plt.tight_layout()
    plt.savefig(os.path.join(save_path_languages, f"{languages[i]}-avg_cpu_temp.pdf"), dpi=300)
    plt.close()


# --- PLOTS PER PROBLEM ---
for i in range(len(problems)):
    caminho_prob = "results/{0}.csv".format(problems[i])
    if not os.path.exists(caminho_prob) or os.path.getsize(caminho_prob) == 0:
        continue

    df = pd.read_csv(caminho_prob, sep=",", header=0, encoding="utf-8")
    df = df.fillna(0)

    plt.figure(figsize=FIGSIZE)
    df.sort_values("avg_total", inplace=True)

    plt.ylabel("Joules")
    bar = plt.bar(df["languages"], df["avg_total"], label="Total Energy")
    plt.bar_label(bar)
    plt.xticks(rotation=30)

    plt.tight_layout()
    plt.savefig(os.path.join(save_path_problems, f"{problems[i]}-total_energy.pdf"), dpi=300)
    plt.close()


# --- GLOBAL COST AND EFFICIENCY ANALYSIS ---
caminho_custo = "results/languages/cost.csv"
if os.path.exists(caminho_custo) and os.path.getsize(caminho_custo) > 0:
    df = pd.read_csv(caminho_custo, sep=",", header=0, encoding="utf-8")
    df = df.fillna(0)

    # Horizontal Bar Chart: Time per Execution
    df.sort_values("time_by_exec", inplace=True, ascending=False)
    plt.figure(figsize=FIGSIZE)
    plt.xlabel("Seconds")
    bar = plt.barh(df["languages"], df["time_by_exec"], label="Time per Execution")
    aplicar_limite_seguro(df, "time_by_exec", 'xlim', 100)

    plt.bar_label(bar, fmt='%.2f')
    plt.tight_layout()
    plt.savefig(os.path.join(save_path_languages, "time_per_execution.pdf"), dpi=300)
    plt.close()

    # Color configuration for energy consumption (Red = High consumption, Green = Low consumption)
    red = Color("red")
    colors_energia = list(red.range_to(Color("green"), len(df)))
    colors_energia = [color.rgb for color in colors_energia]

    # Horizontal Bar Chart: Energy per Execution
    df.sort_values("energy_by_exec", inplace=True, ascending=False)
    plt.figure(figsize=FIGSIZE)
    plt.xlabel("Joules")
    bar = plt.barh(df["languages"], df["energy_by_exec"], label="Energy per Execution", color=colors_energia)
    aplicar_limite_seguro(df, "energy_by_exec", 'xlim', 1000)

    plt.bar_label(bar, fmt='%.2f')
    plt.tight_layout()
    plt.savefig(os.path.join(save_path_languages, "energy_per_execution.pdf"), dpi=300)
    plt.close()

    # --- Normalized Energy Efficiency (vertical bar chart) ---
    if "efficiency" in df.columns:
        # 1. Descending order (from most efficient '1.000' to least efficient, left to right)
        df.sort_values("efficiency", inplace=True, ascending=False)

        # 2. Color gradient from dark green (most efficient) to red (least efficient)
        green_start = Color("green")
        colors_eff = list(green_start.range_to(Color("red"), len(df)))
        colors_eff = [color.rgb for color in colors_eff]

        plt.figure(figsize=FIGSIZE)
        plt.ylabel("Efficiency Index")

        # Plot the vertical bars
        bar = plt.bar(df["languages"], df["efficiency"], color=colors_eff)

        # 3. Y axis limit with headroom (1.15) so the labels above the bars don't get cut off
        plt.ylim(0, 1.15)

        # Add 3-decimal-place text labels above each bar
        plt.bar_label(bar, fmt='%.3f', padding=3, labels=[f"{x:.3f}" if x > 0 else "0" for x in df["efficiency"]])

        # Rotate language names 45 degrees, right-aligned so they don't overlap
        plt.xticks(rotation=45, ha='right')

        plt.tight_layout()

        plt.savefig(os.path.join(save_path_languages, "energy_efficiency.pdf"), dpi=300)
        plt.close()

print("\n>>> Done! All plots were generated separately and saved successfully as PDF.")