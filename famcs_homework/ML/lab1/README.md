# Условие Лабораторной работы
Задача перед вами стоит такая: в  вашем .ipynb построить 15 графиков по этим данным - 5 с помощью matplotlib (где будет возможно согласно типу графика - реализовать это в двух версиях, с вызовом пандаса и с вызовом матплотлиба), 5 с seaborn, 5 с plotly.express

Придумать, что именно рисовать на графиках - ваша задача.

Требования к графикам - чтобы они доносили конкретную мысль, были максимально наглядными и требовали 0 усилий (как мысленных так и визуальных) чтобы понять что мы графиком хотим сказать

Буду смотреть не столько на код, сколько на визуальную составляющую (подписи осей, названия, сетки графиков, выбор типа графика под задачу, итд)

На лабу даётся 2 недели - до 15 октября. За каждую неделю просрочки -2 балла

Помним что на сдачу лабы есть одна попытка чтоб пояснить за происходящее, поэтому если вы будете (а я знаю вы будете, это нынешняя наша база жизни) брать код с нейронки - разбирайтесь в том что нагенерено😃

## Датасет
[тут](https://www.kaggle.com/datasets/nabihazahid/spotify-dataset-for-churn-analysis)



# Команды
## Настройка окружения
- conda create -n spotify_churn python=3.10 -y
- conda activate lab1-spotify
- conda deactivate
- pip install pandas matplotlib seaborn plotly jupyter kaggle
## Установить датасет
- kaggle datasets download -d nabihazahid/spotify-dataset-for-churn-analysis
- unzip spotify-dataset-for-churn-analysis.zip
- https://www.kaggle.com/datasets/nabihazahid/spotify-dataset-for-churn-analysis

