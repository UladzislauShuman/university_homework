#include "mainwindow.h"
#include "ui_mainwindow.h"

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

void MainWindow::PrintComputerItems() {
    ui->output->setText("");
    std::string result{};
    for(auto& item : computerItems) {
        result += item.to_string();
    }
    ui->output->setText((new QString)->fromStdString(result));
}

void MainWindow::on_readFileButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0, "Open dialog", "", "*.txt");
    ReadFile(computerItems, file_name.toStdString());
    PrintComputerItems();
}


void MainWindow::on_saveFileButton_clicked()
{
    std::string result{};
    for(auto& item : computerItems) {
        result += item.to_string();
    }
    QString file_name = QFileDialog::getOpenFileName(0, "Open dialog", "", "*.txt");
    std::ofstream fout(file_name.toStdString());
    fout << result;
}


void MainWindow::on_addItemButton_clicked()
{
    ComputerItem item(
                ui->editType->text().toStdString(),
                ui->editCompany->text().toStdString(),
                ui->editModel->text().toStdString(),
                ui->editParams->text().toStdString(),
                ui->editCost->text().toDouble(),
                ui->checkInStore->isChecked()
                );
    computerItems.push_back(item);
    PrintComputerItems();
}

