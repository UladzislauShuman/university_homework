#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->output->setReadOnly(true);
}


MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::PrintEmployeeProjects() {
    ui->output->setText("");
    std::string result{};
    for(auto& item : employeeProjects) {
        result += item.to_string();
    }
    ui->output->setText((new QString)->fromStdString(result));
}

void MainWindow::on_readFileButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0, "Open dialog", "", "*.txt");
    ReadFile(employeeProjects, file_name.toStdString());
    PrintEmployeeProjects();
}

void MainWindow::on_saveFileButton_clicked()
{
    std::string result{};
    for(auto& item : employeeProjects) {
        result += item.to_string();
    }
    QString file_name = QFileDialog::getOpenFileName(0, "Open dialog", "", "*.txt");
    std::ofstream fout(file_name.toStdString());
    fout << result;
}


void MainWindow::on_addItemButton_clicked()
{
    EmployeeProjects item(
                ui->editEmployeeName->text().toStdString(),
                ui->editProjectName->text().toStdString(),
                ui->editTask->text().toStdString(),
                ui->editDateOfCompletion->text().toStdString(),
                ui->editStartDate->text().toStdString(),
                ui->editEndDate->text().toStdString()
                );
    employeeProjects.push_back(item);
    PrintEmployeeProjects();

    ui->editEmployeeName->clear();
    ui->editProjectName->clear();
    ui->editTask->clear();
    ui->editDateOfCompletion->clear();
    ui->editStartDate->clear();
    ui->editEndDate->clear();
}

void MainWindow::on_openButton_clicked()
{
    QString file_name = QFileDialog::getOpenFileName(0,"Open dialog","","*.txt");
    employeeProjects.erase(employeeProjects.begin(),employeeProjects.end());
    ReadFile(employeeProjects,file_name.toStdString());
    PrintEmployeeProjects();
}

void MainWindow::on_dayButton_clicked()
{        ui->output->setText("");
    std::string result{};
        for(auto& item : employeeProjects) {
        result += item.to_string1();
        result += std::to_string(DayOfWork(item.StartDate(), item.EndDate())) + "\n";
        }
        ui->output->setText((new QString)->fromStdString(result));
}

void MainWindow::on_sortButton_clicked()
{
    std::sort(employeeProjects.begin(),employeeProjects.end(),[](const EmployeeProjects& a,const EmployeeProjects& b){
        return DateEndCompare(a,b);
    });
    PrintEmployeeProjects();
}



void MainWindow::on_searchButton_clicked()
{
    ui->output->setText("");
    std::string result{};
    for(auto& item : employeeProjects) {
        result += item.to_string1();
        result += std::to_string(DayOfWork(item.StartDate(), item.EndDate())) + "\n";
    }
    ui->output->setText((new QString)->fromStdString(result));
}


