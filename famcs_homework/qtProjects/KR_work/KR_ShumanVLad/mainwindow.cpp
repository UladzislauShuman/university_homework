#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    choosePerson = new ChoosePersonDialog();

    pen = new QPen();
    color = Qt::red;
    pen->setColor(color);
    flag = false;

    connect(this, &MainWindow::SignaleMembers,choosePerson,&ChoosePersonDialog::takeMembers);
    connect(choosePerson,&ChoosePersonDialog::SignalPersonIndex,this,&MainWindow::takePersonIndex);
    //connect(this,&MainWindow::SignalTypeFromMainWidget,searchdatedialog,&SearchDateDialog::takeDataFromMainWidget);

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_openButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    ReadFile(this->members,file_name);
    this->maxScore = this->members[0].GetScore();
    PrintMembers();
}

void MainWindow::PrintMembers()
{
    ui->output->setText("");
    std::string result{};
    for(auto& item : members){
        result += item.to_string();
        result += '\n';
    }
    //result += std::to_string(maxScore);
    ui->output->setText((new QString)->fromStdString(result));
}

void MainWindow::paintEvent(QPaintEvent *)
{
    if(this->members.empty())
        return;
    pen->setWidth(35);
    int height = this->height();
    int width = this->width();

    int x0 = 3*width/4;
    int y0 = height;
    int y1 = height * (double)members[current_index-1].GetScore()/maxScore;
    QPainter painter(this);

    painter.begin(this);
    painter.setPen(*pen);
    painter.drawLine(x0,y0,x0,height - y1);
    painter.end();
}


void ReadFile(std::vector<Member>& members, QString& file_name)
{
    std::ifstream in(file_name.toStdString());
    members.clear();
    Member temp;
    while(in >> temp){
        members.push_back(temp);
    }
    std::sort(members.begin(),members.end(),[](Member& a,Member& b){
        return !(a.GetScore() < b.GetScore());
    });
}

void MainWindow::on_pushButton_clicked()
{
    emit SignaleMembers(this->members);
    this->choosePerson->show();
}

void MainWindow::takePersonIndex(int index)
{

    this->current_index = index;
    ui->personLabel->setText((new QString)->fromStdString(this->members[index-1].GetName()));
    if(index-1 == 0){
        ui->heigherLabel->setText("No one");
    }
    else
        ui->heigherLabel->setText((new QString)->fromStdString(this->members[index-2].GetName()));
    this->update();
}

