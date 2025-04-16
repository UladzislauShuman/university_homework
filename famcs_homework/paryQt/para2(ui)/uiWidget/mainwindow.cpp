#include "mainwindow.h"
#include "ui_mainwindow.h"

int MainWindow::turn = 0;
bool MainWindow::flag = 0;
char MainWindow::board[3][3] = {0};

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

bool MainWindow::checkWin()
{
    if(turn < 5) return false;
    else
    {
        for(int i = 0; i<3;i++)
        {
            if(board[i][0] == board[i][1] and board[i][1] == board[i][2] and board[i][0]!='\0' )
            {
                return true;
            }
            if(board[0][i] == board[1][i] and board[1][i] == board[2][i] and board[0][i]!='\0' )
            {
                return true;
            }
        }
        if(board[0][0] == board[1][1] and board[1][1] == board[2][2] and board[0][0] !='\0')
            return true;
        if(board[2][0] == board[1][1] and board[1][1] == board[0][2] and board[2][0] !='\0')
            return true;
    }
    return false;
}

void MainWindow::button (int x,int y,QPushButton* pushButton)
{
    if(pushButton->text() == "" and flag == false)
    {
        if(turn%2 == 0) // если крестик
        {
            pushButton->setText("X");
        }
        else
        {
            pushButton->setText("0");
        }
        turn++;
        board[x][y] = pushButton->text().toStdString()[0];
        if(checkWin())
        {
            ui->resultOfGame->setText(pushButton->text()+" is winner!!!");
            flag = true;
        }
        if(turn==9 and flag == 0)
        {
            ui->resultOfGame->setText("Draw");
        }
    }
}
void MainWindow::on_pushButton00_clicked()
{
    button(0,0,ui->pushButton00);
}

void MainWindow::on_pushButton10_clicked()
{
    button(1,0,ui->pushButton10);
}

void MainWindow::on_pushButton20_clicked()
{
    button(2,0,ui->pushButton20);
}

void MainWindow::on_pushButton01_clicked()
{
    button(0,1,ui->pushButton01);
}

void MainWindow::on_pushButton11_clicked()
{
    button(1,1,ui->pushButton11);
}

void MainWindow::on_pushButton21_clicked()
{
    button(2,1,ui->pushButton21);
}

void MainWindow::on_pushButton12_clicked()
{
    button(1,2,ui->pushButton12);
}

void MainWindow::on_pushButton02_clicked()
{
    button(0,2,ui->pushButton02);
}

void MainWindow::on_pushButton22_clicked()
{
    button(2,2,ui->pushButton22);
}

