#include <QCoreApplication>
#include<QTextStream>
#include<QString>
#include<QMap>
#include<QDebug>
#include<iostream>
#include<map>
using namespace std;

typedef double Price;
typedef int Code;
typedef QPair<Price, Code>QMapI;

void show(QMap<Code,QMapI>&qMap) {
    if (qMap.isEmpty()) {  qDebug() << "Контейнер пуст"; }
    else {
        for (pair<double,int> &x : qMap) {
            qDebug()<< "Цена:" << x.first << "  Код:"<< x.second ;
        }
    }
}

int main(int argc, char *argv[])
{     setlocale(LC_ALL, "RUS");
    QCoreApplication a(argc, argv);
    QTextStream cin(stdin);
    QMap<Code,QMapI>qMap;
    qDebug() << "МЕНЮ:";
    qDebug()<< "1.Показать значения";
    qDebug() << "2.Добавить элемент";
    qDebug() << "3.Удалить элементы из заданного диапазона";
    qDebug() << "4.Поиск элементов меньших заданного ключа";
    qDebug() << "5.Обменять значения двух объектов(отображений)";
    qDebug() << "6.Замена значения элемента" ;
    qDebug() << "7.Выход из программы" ;
    qDebug() << "____________________________________" ;
    qDebug()<<"\n";
    int choice;
    //  pair<double,int> x;

    do {

        std::cin >> choice;
        switch (choice) {
        case 1:{
            show(qMap);
            break;
        }
        case 2:
        {
            Price price;
            Code code;
            qDebug() << "Введите цену: ";
            std::cin >> price;
            qDebug() << "Введите код: ";
            std::cin >> code;
            auto QMapI_=QPair<Price,Code>(price, code);
            qMap[code] = QMapI_;
            break;
        }

        case 3:
        {
            Code Code1, Code2;
            qDebug() << "Введите начальный код диапазона: ";
            std::cin >> Code1;
            qDebug() << "Введите конечный код диапазона: ";
            std::cin >> Code2;

            auto x = qMap.lowerBound(Code1);
            auto end = qMap.upperBound(Code2);

            if (x != end) {
                qMap.erase(x, end);
                qDebug() << "Элементы успешно удалены.";}
            else {
                qDebug() << "Нет элементов для удаления.";}
            break;
        }
        case 4:
        {
            Code limitCode;
            qDebug() << "Введите код: ";
            std:: cin >> limitCode;
            for (const auto& element : qMap) {
                if (element.second < limitCode) {
                    qDebug() << "Цена: " << element.first << "  Код: " << element.second ;}
            }
            break;
        }

        case 5:
        {
            Code price_1, price_2;

            qDebug()<< "Введите код1: ";
            std::cin >> price_1;
            qDebug() << "Введите код2: ";
            std::cin >> price_2;

            auto x1 = qMap.find(price_1);
            auto x2 = qMap.find(price_2);

            if (x1 !=qMap.end() && x2 != qMap.end()) {
                swap(x1->first, x2->first);
            }
            else { qDebug() << "Один из составляющих не найден" ;
            }
            break;
        }
        case 6:{
            Code code_;

            qDebug()<< "Введите код элемента для замены значения: ";
            std::cin >> code_;
            auto x = qMap.find(code_);
            if (x != qMap.end()) {
                Price newPrice;
                qDebug() << "Введите новую цену: ";
                std::cin >> newPrice;
                x->first = newPrice;
                qDebug() << "Значение элемента успешно заменено." ;
            }
            else {
                qDebug() << "Элемент с заданным кодом не найден." ;}
            break;
        }
        case 7:
        {
            break;
        }
        default:{
            break;
        }
        }

    } while (choice != 7);
    return a.exec();
}
