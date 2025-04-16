#include "mainwindow.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    return a.exec();
}

/*
Задание 1. Для заданного вектора натуральных чисел нарисовать вертикальную гистограмму. Размер и элементы вектора вводятся из текстового файла (std::ifstream).
Задание 2. Нарисовать кораблик, который может поднимать флаг, сделать анимацию воды(упрощенно, как в детском рисунке).
*/
