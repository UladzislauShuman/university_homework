#ifndef SEARCHDATEDIALOG_H
#define SEARCHDATEDIALOG_H

#include <QDialog>
#include <QString>
#include "radioitem.h"
#include "searchdialog.h"
#include "errorwindow.h"

namespace Ui {
class SearchDateDialog;
}

class SearchDateDialog : public QDialog
{
    Q_OBJECT

public:
    explicit SearchDateDialog(QWidget *parent = nullptr);
    ~SearchDateDialog();

signals:
    void SignalDate(QString,QString);
    void SignalVector(std::vector<radioitem>&);
public slots:
    void takeDataFromMainWidget(std::vector<radioitem>&);

private slots:
    void on_resultButton_clicked();

    void on_closeButton_clicked();

    void on_findPushButton_clicked();

private:
    Ui::SearchDateDialog *ui;
    SearchDialog* searchdialog;
    ErrorWindow* errorwindow;
    std::vector<radioitem> currentVector;
};

#endif // SEARCHDATEDIALOG_H
