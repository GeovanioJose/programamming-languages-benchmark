import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.patches import Rectangle
from colour import Color
import seaborn as sns
import os

# Configurações padrão de estilo do Seaborn
sns.set_theme(style="white")

languages = ["c", "c++", "c#", "java", "dart", "f#", "fortran", "go", "javascript", "php", "lua", "python", "ruby", "perl", "rust", "julia", "ada", "chapel", "erlang", "haskell", "ocaml", "swift", "racket"]
problems = ["binarytrees","fannkuchredux","fasta","knucleotide","mandelbrot","nbody","pidigits","regexredux","reversecomplement","spectralnorm"]

#plt.style.use("bmh")
#plt.style.use("grayscale")
#Define o tamanho da fonte
plt.rc('font', size=10)  # Define o tamanho da fonte para 12 pontos
plt.rc('axes', titlesize=14)  # Tamanho da fonte do título dos eixos
plt.rc('axes', labelsize=12)  # Tamanho da fonte das etiquetas dos eixos
plt.rc('xtick', labelsize=9)  # Tamanho da fonte do marcador x
plt.rc('ytick', labelsize=9)  # Tamanho da fonte do marcador y
plt.rc('legend', fontsize=10)  # Tamanho da fonte da legenda
plt.rc('figure', titlesize=16)  # Tamanho da fonte do título da figura

# Caminho para a pasta onde os gráficos serão salvos

save_path_languages = "results/plots/languages"
save_path_problems = "results/plots/problems"

# Verifica se os diretórios de salvamento existem, e cria-los caso não existam
if not os.path.exists(save_path_languages):
    os.makedirs(save_path_languages)

if not os.path.exists(save_path_problems):
    os.makedirs(save_path_problems)


for i in range(len(languages)):
    plt.figure(figsize=(16, 9))
    df = pd.read_csv("results/languages/{0}.csv".format(languages[i]), sep=",", header=0, encoding="utf-8")

    df.sort_values("avg_total", inplace=True)

    plt.title("{0}".format(languages[i]).upper())
    plt.ylabel("Joules")
    plt.ylim(0, df["avg_total"].max() * 1.1)
    plt.xticks(rotation=30)
    bar = plt.bar(df["problems"], df["avg_total"])

    for index, value in enumerate(df["avg_total"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')

    # set window aspect
    plt.subplots_adjust(top=0.949, bottom=0.136, left=0.044, right=0.99, hspace=0.2, wspace=0.2)
    w = plt.get_current_fig_manager()
    w.window.showMaximized()

    plt.savefig(os.path.join(save_path_languages, f"{languages[i]}-1.pdf"), dpi=300)
    plt.show()

    plt.figure(figsize=(16, 9))

    # Add main title above all subplots
    plt.suptitle("{0}".format(languages[i]).upper())

    df.sort_values("avg_watts", inplace=True)
    plt.subplot(2, 2, 1)
    plt.title("POTÊNCIA MÉDIA")
    plt.ylabel("Watts")
    bar = plt.bar(df["problems"], df["avg_watts"])
    plt.ylim(0, df["avg_watts"].max() * 1.1)
    plt.xticks(rotation=30)

    for index, value in enumerate(df["avg_watts"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')

    df.sort_values("avg_max_memory", inplace=True)
    plt.subplot(2, 2, 2)
    plt.title("MEMÓRIA MÁXIMA MÉDIA")
    plt.ylabel("MB")
    bar = plt.bar(df["problems"], df["avg_max_memory"])
    plt.ylim(0, df["avg_max_memory"].max() * 1.1)
    plt.xticks(rotation=30)

    for index, value in enumerate(df["avg_max_memory"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')

    df.sort_values("avg_runtime", inplace=True)
    plt.subplot(2, 2, 3)
    plt.title("TEMPO MÉDIO POR EXECUÇÃO")
    plt.ylabel("Segundos")
    bar = plt.bar(df["problems"], df["avg_runtime"])
    plt.ylim(0, df["avg_runtime"].max() * 1.1)
    plt.xticks(rotation=30)

    for index, value in enumerate(df["avg_runtime"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')

    df.sort_values("avg_cpu_temp", inplace=True)
    plt.subplot(2, 2, 4)
    plt.title("TEMPERATURA MÉDIA DA CPU")
    plt.ylabel("ºC")
    bar = plt.bar(df["problems"], df["avg_cpu_temp"])
    plt.ylim([0, 100])
    plt.xticks(rotation=30)

    for index, value in enumerate(df["avg_cpu_temp"]):
        plt.text(index, value, str(round(value, 2)), ha='center', va='bottom')

    # set window aspect
    plt.subplots_adjust(top=0.929, bottom=0.116, left=0.038, right=0.99, hspace=0.339, wspace=0.111)
    w = plt.get_current_fig_manager()
    plt.savefig(os.path.join(save_path_languages, f"{languages[i]}-2.pdf"), dpi=300)
    plt.tight_layout()
    plt.show()

    


for i in range(len(problems)):
    df = pd.read_csv("results/{0}.csv".format(problems[i]),sep=",", header=0, encoding="utf-8")
    plt.figure(figsize=(16, 9))
    
    df.sort_values("avg_total", inplace=True)

    plt.title("{0}".format(problems[i].upper()))
    plt.ylabel("Joules")
    bar = plt.bar(df["languages"],df["avg_total"], label = "Energia Total")
    plt.bar_label(bar)
    plt.xticks(rotation = 30)

    #set window aspect
    plt.subplots_adjust(top=0.949,bottom=0.136,left=0.044,right=0.99,hspace=0.2,wspace=0.2)
    w = plt.get_current_fig_manager()
    w.window.showMaximized()

    plt.savefig(os.path.join(save_path_problems, ("{0}.pdf").format(problems[i])), dpi=300)
    plt.show()

#cost
df = pd.read_csv("results/languages/cost.csv".format(problems[i]),sep=",", header=0, encoding="utf-8")

# df.sort_values("kwh_by_year", inplace=True)

# plt.subplot(2,2,1)
# plt.ylabel("kwh/ano")
# plt.ylim([0,200])
# bar = plt.bar(df["languages"],df["kwh_by_year"], label = "Kwh total em 1 ano")
# plt.bar_label(bar)
# plt.xticks(rotation = 30)
# plt.legend()

# df.sort_values("problems_by_year", inplace=True)

# plt.subplot(2,2,2)
# plt.ylabel("problemas/ano")
# bar = plt.bar(df["languages"],df["problems_by_year"], label = "Problemas por ano")
# plt.bar_label(bar)
# plt.xticks(rotation = 30)
# plt.legend()

# df.sort_values("energy_by_exec", inplace=True)

# plt.subplot(2,2,3)
# plt.ylabel("Joules")
# bar = plt.bar(df["languages"],df["energy_by_exec"], label = "Energia por execução")
# plt.bar_label(bar)
# plt.xticks(rotation = 30)
# plt.legend()

# df.sort_values("time_by_exec", inplace=True)

# plt.subplot(2,2,4)
# plt.ylabel("Segundos")
# bar = plt.bar(df["languages"],df["time_by_exec"], label = "Tempo por execução")
# plt.bar_label(bar)
# plt.xticks(rotation = 30)
# plt.legend()

# #set window aspect
# plt.subplots_adjust(top=0.935,bottom=0.136,left=0.058,right=0.98,hspace=0.439,wspace=0.131)
# w = plt.get_current_fig_manager()
# w.window.showMaximized()

# plt.show()

# df.sort_values("cost_by_year", inplace=True)

# plt.title("Custo em Reais em 1 ano")
# plt.ylabel("Reais")
# bar = plt.bar(df["languages"],df["cost_by_year"], label = "Custo em Reais")
# plt.bar_label(bar)
# plt.xticks(rotation = 30)
# plt.legend()

# #set window aspect
# plt.subplots_adjust(top=0.949,bottom=0.136,left=0.044,right=0.99,hspace=0.2,wspace=0.2)
# w = plt.get_current_fig_manager()
# w.window.showMaximized()

# plt.show()

# Gráfico 1: Tempo por execução
df.sort_values("time_by_exec", inplace=True, ascending=False)
plt.figure(figsize=(16, 9))
plt.title("TEMPO POR EXECUÇÃO")
plt.xlabel("Segundos")
bar = plt.barh(df["languages"], df["time_by_exec"], label="TEMPO POR EXECUÇÃO")
plt.xlim(0, df["time_by_exec"].max() * 1.1)
#plt.legend()


# Adiciona etiquetas aos valores das barras
plt.bar_label(bar, fmt='%.2f')

# Ajusta a janela
plt.subplots_adjust(top=0.949, bottom=0.136, left=0.244, right=0.99, hspace=0.2, wspace=0.2)
w = plt.get_current_fig_manager()
w.window.showMaximized()
plt.tight_layout()
plt.savefig(os.path.join(save_path_languages, "tempo_por_execucao.pdf"), dpi=300)

plt.show()




#cores
red = Color("red")
colors = list(red.range_to(Color("green"),len(df)))
colors = [color.rgb for color in colors]

# Gráfico 2: Energia por execução
df.sort_values("energy_by_exec", inplace=True, ascending=False)
plt.figure(figsize=(16, 9))
plt.title("ENERGIA POR EXECUÇÃO")
plt.xlabel("Joules")
bar = plt.barh(df["languages"], df["energy_by_exec"], label="energia_por_execução", color=colors)
plt.xlim(0, df["energy_by_exec"].max() * 1.1)
#plt.legend()

# Adiciona legenda personalizada
custom_legend = [Rectangle((0, 0), 1, 1, color='green', label='Gastou menos energia'),
                 Rectangle((0, 0), 1, 1, color='red', label='Gastou mais energia')]

plt.legend(handles=custom_legend)


# Adiciona etiquetas aos valores das barras
plt.bar_label(bar, fmt='%.2f')

# Ajusta a janela
plt.subplots_adjust(top=0.949, bottom=0.136, left=0.244, right=0.99, hspace=0.2, wspace=0.2)
w = plt.get_current_fig_manager()
w.window.showMaximized()
plt.tight_layout()
plt.savefig(os.path.join(save_path_languages, "energia_por_execucao.pdf"), dpi=300)
plt.show()



#Eficiencia
green = Color("green")
colors = list(green.range_to(Color("red"),len(df)))
colors = [color.rgb for color in colors]

df.sort_values("efficiency", ascending=False, inplace=True)

plt.figure(figsize=(16, 9))
plt.title("EFICIÊNCIA ENERGÉTICA NORMALIZADA")
plt.ylabel("%")
bar = plt.bar(df["languages"],df["efficiency"], label = "Eficiencia", color=colors)
plt.bar_label(bar)
plt.xticks(rotation = 30)

# Adiciona legenda personalizada
custom_legend = [Rectangle((0, 0), 1, 1, color='green', label='Mais Eficiente'),
                 Rectangle((0, 0), 1, 1, color='red', label='Menos Eficiente')]

plt.legend(handles=custom_legend)


#set window aspect
plt.subplots_adjust(top=0.949,bottom=0.136,left=0.044,right=0.99,hspace=0.2,wspace=0.2)
w = plt.get_current_fig_manager()
w.window.showMaximized()

plt.savefig(os.path.join(save_path_languages, "eficiencia_energetica.pdf"), dpi=300)
plt.show()
