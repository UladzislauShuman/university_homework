import pandas as pd
import matplotlib.pyplot as plt

try:
    raw_df = pd.read_csv('data.csv', header=None, names=['period', 'value'], decimal=',')
except FileNotFoundError:
    print("no data.csv")
    raw_df = pd.DataFrame()

if not raw_df.empty:
    df = raw_df['value'].value_counts().sort_index().reset_index()
    df.columns = ['value', 'freq_mi']
    total_count = df['freq_mi'].sum()

    df['rel_freq_wi'] = df['freq_mi'] / total_count # частость (wi) = частота / общее количество
    df['cum_freq_mi'] = df['freq_mi'].cumsum() # накопленная частота (mi_cum)
    df['cum_rel_freq_wi'] = df['rel_freq_wi'].cumsum() # накопленная частость (wi_cum)

    # таблица
    print("вариационный ряд")
    print(f"всего наблюдений: {total_count}")
    print(f"количество уникальных групп: {len(df)}")
    
    display_df = df.copy()
    display_df.columns = ['значение (xi)', 'частота (mi)', 'частость (wi)', 'накопл. частота', 'накопл. частость']
    print(display_df)

    # графики
    plt.figure(figsize=(14, 6))

    # полигон распределения
    plt.subplot(1, 3, 1)
    plt.plot(df['value'], df['freq_mi'], marker='o', linestyle='-', color='blue', label='полигон')
    plt.title('полигон распределения')
    plt.xlabel('значение индекса (xi)')
    plt.ylabel('частота (mi)')
    plt.ylim(bottom=0) 
    plt.grid(True)

    # кумулята абсолютная
    plt.subplot(1, 3, 2)
    plt.plot(df['value'], df['cum_freq_mi'], marker='o', linestyle='-', color='red', label='кумулята абсолютных частот')
    plt.title('кумулята абсолютный частот')
    plt.xlabel('значение индекса (xi)')
    plt.ylabel('mi^c')
    plt.grid(True)

    # кумулята относительная
    plt.subplot(1, 3, 3)
    plt.plot(df['value'], df['cum_rel_freq_wi'], marker='o', linestyle='-', color='red', label='кумулята относительных частот')
    plt.title('кумулята относительных частот')
    plt.xlabel('значение индекса (xi)')
    plt.ylabel('wi^c')
    plt.grid(True)

    plt.tight_layout()
    plt.show()