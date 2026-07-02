import os
import csv
import pandas as pd
import matplotlib.pyplot as plt

languages = ["c", "c++", "c#", "java", "dart", "f#", "fortran", "go", "javascript", "php", "lua", "python", "ruby", "perl", "rust", "julia", "ada", "chapel", "erlang", "haskell", "ocaml", "swift", "racket"]
problems = ["binarytrees","fannkuchredux","fasta","knucleotide","mandelbrot","nbody","pidigits","regexredux","reversecomplement","spectralnorm"]

#clear_old_results
os.system("rm -rf results")
os.makedirs("results/languages", exist_ok=True)

for i in range(len(languages)):
    for j in range (len(problems)):
        df = pd.read_csv("{0}/{1}/out/{2}_out.csv".format(languages[i], problems[j], problems[j]),sep=",", encoding="utf-8")
        df_runtime = pd.read_csv("{0}/{1}/out/runtime.csv".format(languages[i], problems[j]),sep=",", encoding="utf-8")
        
        #removendo linhas invalidas
        df.drop(df[df.psys < 0].index, inplace=True)

        #removendo outliers
        # Encontrar os índices do maior e do menor valor

        idx_max = df['psys'].idxmax()
        idx_min = df['psys'].idxmin()

        # Remover as linhas correspondentes ao maior e ao menor valor
        df = df.drop([idx_max, idx_min])

        #--------------------------------------

        idx_max = df_runtime['runtime'].idxmax()
        idx_min = df_runtime['runtime'].idxmin()

        # Remover as linhas correspondentes ao maior e ao menor valor
        df_runtime = df_runtime.drop([idx_max, idx_min])



        # avg_total = ((df.loc[0:,"total"].mean()/1000000).round(2))
        # avg_psys = ((df.loc[0:,"psys"].mean()/1000000).round(2))
        # avg_package = ((df.loc[0:,"package"].mean()/1000000).round(2))
        # avg_core = ((df.loc[0:,"core"].mean()/1000000).round(2))
        # avg_uncore = ((df.loc[0:,"uncore"].mean()/1000000).round(2))
        # avg_dram = ((df.loc[0:,"dram"].mean()/1000000).round(2))
        # avg_cpu_temp = ((df.loc[0:,"cpu_temp"].mean()/1000).round(2))
        # avg_runtime = (df_runtime.loc[0:,"runtime"].mean().round(2))
        # avg_max_memory = ((df_runtime.loc[0:,"memory"].mean()/1024).round(0))
        # avg_watts = (avg_total/avg_runtime).round(2)

        # Coluna 'total'
        sorted_total = df['total'].sort_values()
        trimmed_total = sorted_total.iloc[3:-3]
        avg_total = (trimmed_total.mean() / 1000000).round(2)

        # Coluna 'psys'
        sorted_psys = df['psys'].sort_values()
        trimmed_psys = sorted_psys.iloc[3:-3]
        avg_psys = (trimmed_psys.mean() / 1000000).round(2)

        # Coluna 'package'
        sorted_package = df['package'].sort_values()
        trimmed_package = sorted_package.iloc[3:-3]
        avg_package = (trimmed_package.mean() / 1000000).round(2)

        # Coluna 'core'
        sorted_core = df['core'].sort_values()
        trimmed_core = sorted_core.iloc[3:-3]
        avg_core = (trimmed_core.mean() / 1000000).round(2)

        # Coluna 'uncore'
        sorted_uncore = df['uncore'].sort_values()
        trimmed_uncore = sorted_uncore.iloc[3:-3]
        avg_uncore = (trimmed_uncore.mean() / 1000000).round(2)

        # Coluna 'dram'
        sorted_dram = df['dram'].sort_values()
        trimmed_dram = sorted_dram.iloc[3:-3]
        avg_dram = (trimmed_dram.mean() / 1000000).round(2)

        # Coluna 'cpu_temp'
        sorted_cpu_temp = df['cpu_temp'].sort_values()
        trimmed_cpu_temp = sorted_cpu_temp.iloc[3:-3]
        avg_cpu_temp = (trimmed_cpu_temp.mean() / 1000).round(2)

        avg_runtime = (df_runtime.loc[0:,"runtime"].mean().round(2))
        avg_max_memory = ((df_runtime.loc[0:,"memory"].mean()/1024).round(0))
        avg_watts = (avg_total/avg_runtime).round(2)

        # # Exibir as médias calculadas
        # print("Médias:")
        # print(f"Total: {avg_total}")
        # print(f"Psys: {avg_psys}")
        # print(f"Package: {avg_package}")
        # print(f"Core: {avg_core}")
        # print(f"Uncore: {avg_uncore}")
        # print(f"Dram: {avg_dram}")
        # print(f"Cpu_temp: {avg_cpu_temp}")
        # print(f"Runtime: {avg_runtime}")
        # print(f"Max Memory: {avg_max_memory}")
        # print(f"Watts: {avg_watts}")

        #by_problems
        with open('results/{0}.csv'.format(problems[j]), 'a', newline='') as file:
            writer = csv.writer(file)
            if(i == 0):
                writer.writerow(["languages","avg_total","avg_psys","avg_package","avg_core","avg_uncore","avg_dram","avg_runtime","avg_watts","avg_max_memory","avg_cpu_temp"])
            writer.writerow([languages[i], avg_total, avg_psys, avg_package,avg_core,avg_uncore,avg_dram, avg_runtime, avg_watts, avg_max_memory, avg_cpu_temp])
            file.close()

        #by_languages
        with open('results/languages/{0}.csv'.format(languages[i]), 'a', newline='') as file:
            writer = csv.writer(file)
            if(j == 0):
                writer.writerow(["problems","avg_total","avg_psys","avg_package","avg_core","avg_uncore","avg_dram","avg_runtime","avg_watts","avg_max_memory","avg_cpu_temp"])
            writer.writerow([problems[j], avg_total, avg_psys, avg_package,avg_core,avg_uncore,avg_dram, avg_runtime, avg_watts, avg_max_memory, avg_cpu_temp])
            file.close()
#cost
for i in range(len(languages)):
    df = pd.read_csv("results/languages/{0}.csv".format(languages[i]),sep=",", encoding="utf-8")
    energy_by_exec = (df.loc[0:,"avg_total"].sum()).round(2)
    time_by_exec = (df.loc[0:,"avg_runtime"].sum()).round(2)

    problems_by_year = (31536000 / time_by_exec).round(0)
    kwh_by_year = ((energy_by_exec * problems_by_year)/3600000).round(2) #kWh = joules / 3.6 x 10^6
    cost_by_year = (kwh_by_year * 0.69).round(2)
    cost_reais_by_exec =  cost_by_year/problems_by_year


    with open('results/languages/cost.csv'.format(languages[i]), 'a', newline='') as file:
        writer = csv.writer(file)
        if(i == 0):
            writer.writerow(["languages","cost_by_year","kwh_by_year","problems_by_year","energy_by_exec","time_by_exec","cost_reais_by_exec"])
        writer.writerow([languages[i],cost_by_year,kwh_by_year,problems_by_year,energy_by_exec,time_by_exec,cost_reais_by_exec])
        file.close()

#eficiency

df = pd.read_csv("results/languages/cost.csv",sep=",", header=0, encoding="utf-8")

#df["efficiency"] = (abs(((df["energy_by_exec"] - df["energy_by_exec"].min()) / ( df["energy_by_exec"].max() - df["energy_by_exec"].min())) - 1)).round(3)
#df["efficiency"] = ((df["energy_by_exec"] - df["energy_by_exec"].min()) / (df["energy_by_exec"].max() - df["energy_by_exec"].min())).round(3)
# (x - xmin) / (xmax - xmin) 
df["efficiency"] = 1 - ((df["energy_by_exec"] - df["energy_by_exec"].min()) / (df["energy_by_exec"].max() - df["energy_by_exec"].min())).round(3)


print(df.sort_values(by='efficiency', ascending=False).to_string(index=False))

df.to_csv('results/languages/cost.csv',index=False)

