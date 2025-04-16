#ifndef SEARCHDIALOG_H
#define SEARCHDIALOG_H

#include <QDialog>
#include <QString>
#include <vector>

#include "radioitem.h"
#include "errorwindow.h"

namespace Ui {
class SearchDialog;
}

class SearchDialog : public QDialog
{
    Q_OBJECT

public:
    explicit SearchDialog(QWidget *parent = nullptr);
    ~SearchDialog();

private slots:
    void on_findButton_clicked();

    void on_closeButton_clicked();

public slots:
    void takeVector(std::vector<radioitem>&);
private:
    Ui::SearchDialog *ui;
    std::vector<radioitem> currentVector;
};

#endif // SEARCHDIALOG_H
