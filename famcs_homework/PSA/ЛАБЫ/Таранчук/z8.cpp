#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <cctype>
#include <chrono>

using namespace std;

int main() {
    setlocale(LC_ALL, "Russian");

    cout << "VAZHNO!" << endl;
    cout << "- fajl nahoditsya v odnom meste s programmoj" << endl;
    cout << "- nazyvaetsya text.txt" << endl;
    cout << "- format: {{1, 1}, {1, 1}}" << endl;


    ifstream in("test.txt");
    if (!in) {
        cout << "Ne udalos' otkryt' fajl 'test.txt'" << endl;
        cout << "Polozhite fajl s dannymi ryadom s programmoj" << endl;
        system("pause");
        return 1;
    }

    vector<vector<int>> matrix;
    vector<int> current_row;
    string current_num = "";
    char c;

    while (in.get(c)) {
        if (isdigit(c) || c == '-') {
            current_num += c;
        } else {
            if (!current_num.empty()) {
                current_row.push_back(stoi(current_num));
                current_num = "";
            }
            if (c == '}' || c == ')' || c == ']') {
                if (!current_row.empty()) {
                    matrix.push_back(current_row);
                    current_row.clear();
                }
            }
        }
    }
    if (!current_num.empty()) current_row.push_back(stoi(current_num));
    if (!current_row.empty()) matrix.push_back(current_row);

    in.close();

    if (matrix.empty()) {
        cout << "matrica pustaja" << endl;
        system("pause");
        return 1;
    }

    auto start_time = chrono::high_resolution_clock::now();

    long long total_sum = 0;
    int matching_rows_count = 0;

    for (size_t i = 0; i < matrix.size(); ++i) {
        if (i < matrix[i].size() && matrix[i][i] < 0) {
            matching_rows_count++;
            for (size_t j = 0; j < matrix[i].size(); ++j) {
                total_sum += matrix[i][j];
            }
        }
    }

    auto end_time = chrono::high_resolution_clock::now();

    chrono::duration<double, milli> elapsed = end_time - start_time;

    cout << "Kolichestvo strok: " << matrix.size() << endl;
    cout << "------------------------------------------------" << endl;
    cout << "Napominayu uslovie zadaniya: Summa elementov v strokah s otricatel'nym elementom na glavnoj diagonali." << endl;
    cout << "Itogo: " << total_sum << endl;
    cout << "------------------------------------------------" << endl;
    
    // Вывод времени
    cout << "Vremya raboty algoritma: " << elapsed.count() << " ms (millisekund)" << endl;
    cout << "------------------------------------------------" << endl;

    system("pause");
    return 0;
}