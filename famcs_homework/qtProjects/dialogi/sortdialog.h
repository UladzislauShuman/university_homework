#ifndef SORTDIALOG_H
#define SORTDIALOG_H

#include <QDialog>

namespace Ui {
class SortDialog;
}

class SortDialog : public QDialog
{
    Q_OBJECT

public:
    explicit SortDialog(QWidget *parent = nullptr);
    ~SortDialog();

signals:
    void SignalSortType(QString);

public slots:

    void slotSort(QString);

private slots:
    void on_sortButton_clicked();

    void on_closeButton_clicked();

private:
    Ui::SortDialog *ui;
};

#endif // SORTDIALOG_H
