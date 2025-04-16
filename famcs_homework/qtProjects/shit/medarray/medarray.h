#ifndef MEDARRAY_H
#define MEDARRAY_H

#include <iostream>
#include <vector>
#include <algorithm>
#include <cstring>
#include <QString>
#include <QDate>
#include <QMessageBox>

struct MedItem {
    char name[35];
    char expiryDate[8]; // Format MM.YYYY
    char section[20];
    double price;
    int amount;

    // Конструктор по умолчанию
    MedItem() : price(0.0), amount(0) {
        std::memset(name, 0, sizeof(name));
        std::memset(expiryDate, 0, sizeof(expiryDate));
        std::memset(section, 0, sizeof(section));
    }

    bool operator==(const MedItem& other) const {
        return std::strcmp(name, other.name) == 0;
    }

    bool operator<(const MedItem& other) const {
        return std::strcmp(name, other.name) < 0;
    }

    friend std::ostream& operator<<(std::ostream& os, const MedItem& item) {
        os << item.name << " " << item.expiryDate << " " << item.section << " " << item.price << " " << item.amount;
        return os;
    }

    friend std::istream& operator>>(std::istream& is, MedItem& item) {
        is >> item.name >> item.expiryDate >> item.section >> item.amount;
        return is;
    }
};

class MedArray {
protected:
    std::vector<MedItem> meds;

public:
    std::vector<MedItem>& GetMeds() {
        return meds;
    }

    void WriteMeds(std::ostream& os) {
        for (const auto& med : meds) {
            os << med << std::endl;
        }
    }

    void ReadMeds(std::istream& is) {
        MedItem med;
        while (is >> med) {
            meds.push_back(med);
        }
    }

    void SortMeds() {
        std::sort(meds.begin(), meds.end());
    }

    MedItem* FindMed(const char* name) {
        auto it = std::find_if(meds.begin(), meds.end(), [name](const MedItem& med) {
            return std::strcmp(med.name, name) == 0;
        });
        return (it != meds.end()) ? &(*it) : nullptr;
    }

    void FindMedsByDate(const char* date, std::vector<MedItem>& result, bool expired = false) const {
        QDate targetDate = QDate::fromString(QString::fromUtf8(date), "MM.yyyy");

        if (!targetDate.isValid()) {
            QMessageBox::warning(nullptr, "Error", "Invalid date format. Please use MM.yyyy format.");
            return;
        }

        result.clear();

        for (const auto& med : meds) {
            QDate expiryDate = QDate::fromString(QString::fromUtf8(med.expiryDate), "MM.yyyy");
            if (expiryDate.isValid() && (expired ? expiryDate < targetDate : expiryDate >= targetDate)) {
                result.push_back(med);
            }
        }
    }
};

#endif // MEDARRAY_H
