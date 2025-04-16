#include "mainwindow.h"
#include "ui_mainwindow.h"

int MainWindow::turn=0;
bool MainWindow::flag=0;
char MainWindow::board[3][3]={0};


MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}
bool MainWindow::checkWin(){
    if(turn<5) return false;
    else{
        for(int i=0;i<3;i++){
            if(board[i][0]==board[i][1]&&board[i][1]==board[i][2]&&board[i][0]!='\0')
                return true;

            if(board[0][i]==board[1][i]&&board[1][i]==board[2][i]&&board[0][i]!='\0')
                return true;
        }
        if(board[0][0]==board[1][1]&&board[1][1]==board[2][2]&&board[0][0]!='\0')
            return true;
        if(board[2][0]==board[1][1]&&board[1][1]==board[0][2]&&board[2][0]!='\0')
            return true;
    }
    return false;
};

void MainWindow::ClickHandler(int row, int col, QPushButton* button) {
    if(button->text()==""&&flag==0 )
    {
        if(turn%2==0)
          button->setText("X");
        else
          button->setText("0");
        turn++;
        board[row][col]=button->text().toStdString()[0];
        if (checkWin())
        {
            ui->label->setText(button->text()+" win!!!");
            flag=true;
        }
        if(turn==9&&flag==0)
            ui->label->setText("Draw");
    }
}

void MainWindow::on_pushButton00_clicked()
{
    ClickHandler(0, 0, ui->pushButton00);
}


void MainWindow::on_pushButton10_clicked()
{
    ClickHandler(1, 0, ui->pushButton10);
}


void MainWindow::on_pushButton20_clicked()
{
    ClickHandler(2, 0, ui->pushButton20);
}


void MainWindow::on_pushButton01_clicked()
{
    ClickHandler(0, 1, ui->pushButton01);
}


void MainWindow::on_pushButton02_clicked()
{
    ClickHandler(0, 2, ui->pushButton02);
}


void MainWindow::on_pushButton11_clicked()
{
    ClickHandler(1, 1, ui->pushButton11);
}


void MainWindow::on_pushButton21_clicked()
{
    ClickHandler(2, 1, ui->pushButton21);
}


void MainWindow::on_pushButton12_clicked()
{
    ClickHandler(1, 2, ui->pushButton12);
}


void MainWindow::on_pushButton22_clicked()
{
    ClickHandler(2, 2, ui->pushButton22);
}

