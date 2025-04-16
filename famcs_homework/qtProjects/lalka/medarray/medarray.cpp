#include "medarray.h"
#include <QFileDialog>
#include <QMessageBox>
#include <QLineEdit>
#include <QDate>
#include <fstream>

template<typename T>
void MedArray<T>::WriteMeds(std::ostream& os) {
    for (const auto& med : this->meds) {
        os << med << std::endl;
    }
}

template<typename T>
void MedArray<T>::ReadMeds(std::istream& is) {
    MedItem<T> med;
    while (is >> med) {
        this->meds.push_back(med);
    }
}

template<typename T>
void MedArray<T>::SortMeds() {
    std::sort(this->meds.begin(), this->meds.end());
}

template<typename T>
MedItem<T>* MedArray<T>::FindMed(const T* name) {
    auto it = std::find_if(this->meds.begin(), this->meds.end(), [name](const MedItem<T>& med) {
        return std::strcmp(med.name, name) == 0;
    });
    return (it != this->meds.end()) ? &(*it) : nullptr;
}

template<typename T>
void MedArray<T>::FindMedsByDate(const T* date, std::vector<MedItem<T>>& result) const {
    QDate targetDate = QDate::fromString(QString::fromUtf8(date), "MM.yyyy");

    if (!targetDate.isValid()) {
        QMessageBox::warning(nullptr, "Error", "Invalid date format. Please use MM.yyyy format.");
        return;
    }

    result.clear();

    for (const auto& med : this->meds) {
        QDate expiryDate = QDate::fromString(QString::fromUtf8(med.expiryDate), "MM.yyyy");
        if (expiryDate.isValid() && expiryDate >= targetDate) {
            result.push_back(med);
        }
    }
}

// Явные инстанцирования шаблонов для типов, которые вы будете использовать
template class MedArray<char>;
