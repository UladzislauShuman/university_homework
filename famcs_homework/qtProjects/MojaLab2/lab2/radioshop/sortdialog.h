#ifndef SORTDIALOG_H
#define SORTDIALOG_H

#include <QDialog>
#include <QString>

namespace Ui {
class SortDialog;
}

class SortDialog : public QDialog
{
    Q_OBJECT

public:
    explicit SortDialog(QWidget *parent = nullptr);
    ~SortDialog();

private slots:
    void on_dateEndRadio_clicked(bool checked);

    void on_doneRadio_clicked(bool checked);

    void on_typeRadio_clicked(bool checked);

    void on_closeButton_clicked();
signals:
    void SignalSort(QString,bool);
private:
    Ui::SortDialog *ui;
    QString act;
};

#endif // SORTDIALOG_H
