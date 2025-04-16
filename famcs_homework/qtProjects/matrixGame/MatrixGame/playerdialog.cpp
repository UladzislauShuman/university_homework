#include "playerdialog.h"
#include "ui_playerdialog.h"

PlayerDialog::PlayerDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::PlayerDialog)
{
    qDebug() << "PlayerDialog::PlayerDialog(QWidget)"<<Qt::endl;
    ui->setupUi(this);
    this->player = new Player();
    this->PrintInf();
}

PlayerDialog::~PlayerDialog()
{
    qDebug() << "PlayerDialog::~PlayerDialog()"<<Qt::endl;
    delete ui;
    delete player;
}

void PlayerDialog::PrintInf()
{
    qDebug() << "PlayerDialog::PrintInf()"<<Qt::endl;
    this->ui->player_nameLabel->setText((new QString)->fromStdString(this->player->GetName()));
    this->ui->player_maxLevelLabel->setText((new QString)->number(this->player->GetMaxLevel()));
    this->ui->player_currentLevelLabel->setText((new QString)->number(this->player->GetCurrentLevel()));
}

void PlayerDialog::on_okButton_clicked()
{
    qDebug() << "PlayerDialog::on_okButton_clicked()"<<Qt::endl;
    emit SignalPlayer(*this->player,this->current_player_file);
    emit SignalPlayerWasChoosen(true);
    this->close();
}


void PlayerDialog::on_chooseProfileButton_clicked()
{
    qDebug() << "PlayerDialog::on_chooseProfileButton_clicked()"<<Qt::endl;
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    this->current_player_file = file_name.toStdString();
    ReadFile(file_name.toStdString());
}


void PlayerDialog::ReadFile(std::string file_name)
{
    qDebug() << "PlayerDialog::ReadFile(std::string)"<<Qt::endl;
    std::ifstream in(file_name);

    std::string name_;
    std::getline(in, name_);
    this->player->SetName(name_);

    int max;
    in >> max;
    this->player->SetMaxLevel(max);

    int current;
    in >> current;
    this->player->SetCurrentLevel(current);

    this->PrintInf();
}

void PlayerDialog::takePlayerFromMainWindow(Player* player_)
{
    qDebug() << "PlayerDialog::takePlayerFromMainWindow(Player*)"<<Qt::endl;
    this->player->SetName(player_->GetName());
    this->player->SetMaxLevel(player_->GetMaxLevel());
    this->player->SetCurrentLevel(player_->GetCurrentLevel());
    this->PrintInf();
}

void PlayerDialog::on_makeProfileButton_clicked()
{
    this->ui->stackedWidget->setCurrentWidget(this->ui->makePlayerPage);
}


void PlayerDialog::on_createButton_clicked()
{
    Player player_;
    player_.SetName(this->ui->nameEdit->text().toStdString());
    player_.SetCurrentLevel(1);
    player_.SetMaxLevel(1);
    QString fileName = QFileDialog::getSaveFileName(this, tr("Save File"),QDir::homePath(), tr("Text Files (*.txt)"));
    if (!fileName.isEmpty()) {
        QFile file(fileName);
        if (file.open(QIODevice::WriteOnly)) {
            // Тут код для записи данных в файл
            QTextStream out(&file);
            out << QString::fromStdString(player_.GetName()) << Qt::endl;
            out << 1 << Qt::endl;
            out << 1 << Qt::endl;
            file.close();
        }
    }
    this->player->SetName(player_.GetName());
    this->player->SetCurrentLevel(player_.GetCurrentLevel());
    this->player->SetMaxLevel(player_.GetMaxLevel());
    this->current_player_file = fileName.toStdString();
    this->ui->stackedWidget->setCurrentWidget(this->ui->playerPage);
    this->PrintInf();
}


void PlayerDialog::on_backButton_clicked()
{
    this->ui->stackedWidget->setCurrentWidget(this->ui->playerPage);
}

