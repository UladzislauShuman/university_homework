#include "choosepersondialog.h"
#include "ui_choosepersondialog.h"

ChoosePersonDialog::ChoosePersonDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::ChoosePersonDialog)
{
    ui->setupUi(this);
}

ChoosePersonDialog::~ChoosePersonDialog()
{
    delete ui;
}


void ChoosePersonDialog::takeMembers(std::vector<Member>& members)
{
    for(int i = 0; i < members.size();++i){
        ui->comboBox->addItem((new QString)->fromStdString(std::to_string(i+1) +
                                                           ". " +
                                                           members[i].to_string()));
    }
}


void ChoosePersonDialog::on_resultButton_clicked()
{
    std::istringstream strIn(ui->comboBox->currentText().toStdString());
    int person_index;
    strIn >> person_index;
    emit SignalPersonIndex(person_index);

}

