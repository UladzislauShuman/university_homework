#ifndef CHOOSEPERSONDIALOG_H
#define CHOOSEPERSONDIALOG_H

#include <QDialog>
#include <QString>
#include <QFileDialog>

#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

#include <member.h>

namespace Ui {
class ChoosePersonDialog;
}

class ChoosePersonDialog : public QDialog
{
    Q_OBJECT

public:
    explicit ChoosePersonDialog(QWidget *parent = nullptr);
    ~ChoosePersonDialog();

private slots:

    void on_resultButton_clicked();

public slots:
    void takeMembers(std::vector<Member>&);
private:
    Ui::ChoosePersonDialog *ui;

signals:
    void SignalPersonIndex(int);
};

#endif // CHOOSEPERSONDIALOG_H
