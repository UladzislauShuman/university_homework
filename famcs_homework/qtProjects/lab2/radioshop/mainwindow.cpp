#include "mainwindow.h"
#include "ui_mainwindow.h"

#include "functions.h"
MainWindow::MainWindow(QWidget *parent): QMainWindow(parent), ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->output->setReadOnly(true);
    searchdatedialog = new SearchDateDialog();
    sortdialog = new SortDialog();
    errorwindow = new ErrorWindow();
    //       автор сигнала                                  кто за ним следит
    //      откуда               сигнал                     вот это наше окно             что его будет обрабатывать
    connect(searchdatedialog, &SearchDateDialog::SignalDate, this,              &MainWindow::takeDateFromDateDialog);
    connect(this,&MainWindow::SignalTypeFromMainWidget,searchdatedialog,&SearchDateDialog::takeDataFromMainWidget);

    connect(sortdialog, &SortDialog::SignalSort,this,&MainWindow::takeSortDialog);
}

MainWindow::~MainWindow()
{
    delete ui;
    delete searchdatedialog;
}

void MainWindow::PrintRadioitems()
{
    ui->output->setText("");
    std::string result{};
    for(auto& item : radioitems){
        result += item.to_string();
    }
    ui->output->setText((new QString)->fromStdString(result));
}

void MainWindow::on_readFileButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    ReadFile(radioitems,file_name.toStdString());
    PrintRadioitems();
}

void MainWindow::on_saveFileButton_clicked()
{
    std::string result{};
    for(auto& item:radioitems){
        result += item.to_string();
    }
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    std::ofstream fout(file_name.toStdString());
    fout << result;
}

void MainWindow::on_additonButton_clicked()
{
    radioitem item
        (
        ui->editType->text().toStdString(),
        ui->editCompany->text().toStdString(),
        ui->editDateStart->text().toStdString(),
        ui->editDateEnd->text().toStdString(),
        ui->checkIsDone->isChecked()
        );

    if( checkDate(item.DateStart()) == false or
        checkDate(item.DateEnd()) == false or
        DateCompare(item.DateStart(),item.DateEnd()) == false){
        this->errorwindow->show();
        return;
    }

    radioitems.push_back(item);
    PrintRadioitems();
    ui->editCompany->clear();
    ui->editDateEnd->clear();
    ui->editDateStart->clear();
    ui->editType->clear();
    ui->checkIsDone->setChecked(false);
}

void MainWindow::on_cleanButton_clicked()
{
    radioitems.erase(radioitems.begin(),radioitems.end());
    PrintRadioitems();
}

void MainWindow::on_openButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    radioitems.erase(radioitems.begin(),radioitems.end());
    ReadFile(radioitems,file_name.toStdString());
    PrintRadioitems();
}

void MainWindow::on_searchDateButton_clicked()
{
    searchdatedialog->show();
}

//выдать информацию о состоянии готовности заказов на текущие сутки по группам изделий;
//где-то теряется Horizont
void MainWindow::takeDateFromDateDialog(QString qstr,QString checkBoxAct)
{
    std::string date = qstr.toStdString();
    std::sort(radioitems.begin(),radioitems.end(),[](const radioitem& a,const radioitem& b){
        return !(a.IsDone() < b.IsDone());
    }); //1,1,1,1,....,1,0,0,0,0

    auto beginPtr = radioitems.begin();
    auto endPtr = radioitems.end();

    if(checkBoxAct == "готовы"){

        endPtr = std::find_if(radioitems.begin(),endPtr,[](const radioitem& a){
            return a.IsDone() == false;
        });//первый false

    }
    if(checkBoxAct == "не готовы"){
        beginPtr = std::find_if(radioitems.begin(),endPtr,[](const radioitem& a){
            return a.IsDone() == false;
        });
    }
    std::sort(beginPtr,endPtr,[](const radioitem& a,const radioitem& b){
        return DateEndCompare(a,b);
    });

    auto ptr =std::find_if(beginPtr,endPtr,[date](const radioitem& a){
        return DateEndCompare(radioitem(" "," "," ",date,0),a);
    });

    //сортирует именно в этих пределах
    std::sort(beginPtr,ptr,[](const radioitem& a,const radioitem& b){
        return a.Type() < b.Type();
    });

    std::vector<radioitem> answer;
    for (auto i = beginPtr; i != ptr; ++i) {
        answer.push_back(*i);
    }

    //emit SignalTypeFromMainWidget((new QString)->fromStdString(result));
    emit SignalTypeFromMainWidget(answer);
}

void MainWindow::on_sortButton_clicked()
{
    sortdialog->show();
}

void MainWindow::takeSortDialog(QString act,bool NO)
{
    if(act == "type"){
        std::sort(radioitems.begin(),radioitems.end(),[NO](const radioitem& a,const radioitem& b){
                return a.Type()<b.Type();
        });
    }
    else if(act == "dateEnd"){
        std::sort(radioitems.begin(),radioitems.end(),[NO](const radioitem& a,const radioitem& b){
            return DateEndCompare(a,b);
        });
    }
    else if(act == "done"){
        std::sort(radioitems.begin(),radioitems.end(),[NO](const radioitem& a,const radioitem& b){
            return a.IsDone()<b.IsDone();
        });
    }

    if(NO == false){
        std::reverse(radioitems.begin(),radioitems.end());
    }
    PrintRadioitems();
}
