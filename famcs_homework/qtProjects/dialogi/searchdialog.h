#ifndef SEARCHDIALOG_H
#define SEARCHDIALOG_H

#include <QDialog>
#include <QString>

namespace Ui {
class SearchDialog;
}

class SearchDialog : public QDialog
{
    Q_OBJECT

public:
    explicit SearchDialog(QWidget *parent = nullptr);
    ~SearchDialog();

signals:
    void SignalModel(QString);

public slots:

    void slotModel(QString);

private slots:
    void on_searchButton_clicked();

    void on_closeDialogButton_clicked();

private:
    Ui::SearchDialog *ui;
};

#endif // SEARCHDIALOG_H
