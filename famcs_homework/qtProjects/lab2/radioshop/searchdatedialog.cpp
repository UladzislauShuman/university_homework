#include "searchdatedialog.h"
#include "ui_searchdatedialog.h"
#include "functions.h"


SearchDateDialog::SearchDateDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::SearchDateDialog)
{
    ui->setupUi(this);
    ui->output->setReadOnly(true);
    searchdialog = new SearchDialog();
    errorwindow = new ErrorWindow();
    //       автор сигнала                                  кто за ним следит
    //      откуда               сигнал                     вот это наше окно             что его будет обрабатывать
    connect(this,&SearchDateDialog::SignalVector,searchdialog,&SearchDialog::takeVector);
}

SearchDateDialog::~SearchDateDialog()
{
    delete ui;
}

void SearchDateDialog::takeDataFromMainWidget(std::vector<radioitem>& vec)
{
    if(ui->checkBox->isChecked()){
        std::sort(vec.begin(),vec.end(),[](const radioitem& a,const radioitem& b){
            return a.Type() < b.Type();
        });

        auto beginTemp = vec.begin();
        auto endTemp = std::find_if(beginTemp,vec.end(),[beginTemp](const radioitem& a){
            return (*beginTemp).Type() != a.Type();
        });
        while(beginTemp != vec.end())
        {
            endTemp = std::find_if(beginTemp,vec.end(),[beginTemp](const radioitem& a){
                return (*beginTemp).Type() != a.Type();
            });
            std::sort(beginTemp,endTemp,[](const radioitem& a,const radioitem& b){
                return DateEndCompare(a,b);
            });
            beginTemp = endTemp;
        }
    }
    else{
        std::sort(vec.begin(),vec.end(),[](const radioitem& a,const radioitem& b){
            return DateEndCompare(a,b);
        });
    }
    currentVector = vec;
    std::string result ="";
    for (auto i = vec.begin(); i != vec.end(); ++i) {
        result += (*i).to_string();
    }
    ui->output->setText((new QString)->fromStdString(result));
}

void SearchDateDialog::on_resultButton_clicked()
{
    std::string date = ui->currentDateEdit->text().toStdString();
    if(checkDate(date) == false){
        errorwindow->show();
    }
    else {
        if(ui->currentDateEdit->text() == ""){
            ui->currentDateEdit->setText("99.99.9999");
        }
        emit SignalDate(ui->currentDateEdit->text(),ui->comboBox->currentText());
    }
}

void SearchDateDialog::on_closeButton_clicked()
{
    ui->checkBox->setChecked(false);
    ui->currentDateEdit->clear();
    ui->output->clear();
    this->close();
}

void SearchDateDialog::on_findPushButton_clicked()
{
    searchdialog->show();
    emit SignalVector(currentVector);
}

