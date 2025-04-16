#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent): QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    this->setWindowTitle("Меню выбора");
    gistograma = new GistogramaDialog();
    gistograma->setWindowTitle("Гистограма");
    gistograma->setAttribute(Qt::WA_DeleteOnClose);
    boat = new BoatDialog();
    boat->setAttribute(Qt::WA_DeleteOnClose);
    boat->setWindowTitle("Лодка");
}

MainWindow::~MainWindow()
{
    delete ui;
    delete gistograma;
    delete boat;
}

void MainWindow::on_zad1Button_clicked()
{
    gistograma->show();
}


void MainWindow::on_zad2Button_clicked()
{
    boat->show();
}

