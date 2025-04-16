/****************************************************************************
** Meta object code from reading C++ file 'mainwindow.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.6.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../mainwindow.h"
#include <QtCore/qmetatype.h>

#if __has_include(<QtCore/qtmochelpers.h>)
#include <QtCore/qtmochelpers.h>
#else
QT_BEGIN_MOC_NAMESPACE
#endif


#include <memory>

#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'mainwindow.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.6.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
QT_WARNING_DISABLE_GCC("-Wuseless-cast")
namespace {

#ifdef QT_MOC_HAS_STRINGDATA
struct qt_meta_stringdata_CLASSMainWindowENDCLASS_t {};
constexpr auto qt_meta_stringdata_CLASSMainWindowENDCLASS = QtMocHelpers::stringData(
    "MainWindow",
    "SignalPlayerMainWindow",
    "",
    "Player*",
    "SignalWaitAMinute",
    "on_startButton_clicked",
    "on_pushButton_clicked",
    "on_settingsButton_clicked",
    "on_playerButton_clicked",
    "takeCurrentXY",
    "takeFieldSize",
    "takePlayer",
    "Player",
    "std::string",
    "takeAttemptsFromField",
    "takeSignalNext",
    "takeSignalMakeNewField",
    "takePlayerOrSettings"
);
#else  // !QT_MOC_HAS_STRING_DATA
struct qt_meta_stringdata_CLASSMainWindowENDCLASS_t {
    uint offsetsAndSizes[36];
    char stringdata0[11];
    char stringdata1[23];
    char stringdata2[1];
    char stringdata3[8];
    char stringdata4[18];
    char stringdata5[23];
    char stringdata6[22];
    char stringdata7[26];
    char stringdata8[24];
    char stringdata9[14];
    char stringdata10[14];
    char stringdata11[11];
    char stringdata12[7];
    char stringdata13[12];
    char stringdata14[22];
    char stringdata15[15];
    char stringdata16[23];
    char stringdata17[21];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_CLASSMainWindowENDCLASS_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_CLASSMainWindowENDCLASS_t qt_meta_stringdata_CLASSMainWindowENDCLASS = {
    {
        QT_MOC_LITERAL(0, 10),  // "MainWindow"
        QT_MOC_LITERAL(11, 22),  // "SignalPlayerMainWindow"
        QT_MOC_LITERAL(34, 0),  // ""
        QT_MOC_LITERAL(35, 7),  // "Player*"
        QT_MOC_LITERAL(43, 17),  // "SignalWaitAMinute"
        QT_MOC_LITERAL(61, 22),  // "on_startButton_clicked"
        QT_MOC_LITERAL(84, 21),  // "on_pushButton_clicked"
        QT_MOC_LITERAL(106, 25),  // "on_settingsButton_clicked"
        QT_MOC_LITERAL(132, 23),  // "on_playerButton_clicked"
        QT_MOC_LITERAL(156, 13),  // "takeCurrentXY"
        QT_MOC_LITERAL(170, 13),  // "takeFieldSize"
        QT_MOC_LITERAL(184, 10),  // "takePlayer"
        QT_MOC_LITERAL(195, 6),  // "Player"
        QT_MOC_LITERAL(202, 11),  // "std::string"
        QT_MOC_LITERAL(214, 21),  // "takeAttemptsFromField"
        QT_MOC_LITERAL(236, 14),  // "takeSignalNext"
        QT_MOC_LITERAL(251, 22),  // "takeSignalMakeNewField"
        QT_MOC_LITERAL(274, 20)   // "takePlayerOrSettings"
    },
    "MainWindow",
    "SignalPlayerMainWindow",
    "",
    "Player*",
    "SignalWaitAMinute",
    "on_startButton_clicked",
    "on_pushButton_clicked",
    "on_settingsButton_clicked",
    "on_playerButton_clicked",
    "takeCurrentXY",
    "takeFieldSize",
    "takePlayer",
    "Player",
    "std::string",
    "takeAttemptsFromField",
    "takeSignalNext",
    "takeSignalMakeNewField",
    "takePlayerOrSettings"
};
#undef QT_MOC_LITERAL
#endif // !QT_MOC_HAS_STRING_DATA
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_CLASSMainWindowENDCLASS[] = {

 // content:
      12,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   92,    2, 0x06,    1 /* Public */,
       4,    0,   95,    2, 0x06,    3 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       5,    0,   96,    2, 0x08,    4 /* Private */,
       6,    0,   97,    2, 0x08,    5 /* Private */,
       7,    0,   98,    2, 0x08,    6 /* Private */,
       8,    0,   99,    2, 0x08,    7 /* Private */,
       9,    2,  100,    2, 0x0a,    8 /* Public */,
      10,    2,  105,    2, 0x0a,   11 /* Public */,
      11,    2,  110,    2, 0x0a,   14 /* Public */,
      14,    1,  115,    2, 0x0a,   17 /* Public */,
      15,    1,  118,    2, 0x0a,   19 /* Public */,
      16,    1,  121,    2, 0x0a,   21 /* Public */,
      17,    1,  124,    2, 0x0a,   23 /* Public */,

 // signals: parameters
    QMetaType::Void, 0x80000000 | 3,    2,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    2,    2,
    QMetaType::Void, QMetaType::Int, QMetaType::Int,    2,    2,
    QMetaType::Void, 0x80000000 | 12, 0x80000000 | 13,    2,    2,
    QMetaType::Void, QMetaType::Int,    2,
    QMetaType::Void, QMetaType::Bool,    2,
    QMetaType::Void, QMetaType::Bool,    2,
    QMetaType::Void, QMetaType::Bool,    2,

       0        // eod
};

Q_CONSTINIT const QMetaObject MainWindow::staticMetaObject = { {
    QMetaObject::SuperData::link<QMainWindow::staticMetaObject>(),
    qt_meta_stringdata_CLASSMainWindowENDCLASS.offsetsAndSizes,
    qt_meta_data_CLASSMainWindowENDCLASS,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_CLASSMainWindowENDCLASS_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<MainWindow, std::true_type>,
        // method 'SignalPlayerMainWindow'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<Player *, std::false_type>,
        // method 'SignalWaitAMinute'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_startButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_pushButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_settingsButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'on_playerButton_clicked'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'takeCurrentXY'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'takeFieldSize'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'takePlayer'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<Player, std::false_type>,
        QtPrivate::TypeAndForceComplete<std::string, std::false_type>,
        // method 'takeAttemptsFromField'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'takeSignalNext'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'takeSignalMakeNewField'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        // method 'takePlayerOrSettings'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<bool, std::false_type>
    >,
    nullptr
} };

void MainWindow::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<MainWindow *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->SignalPlayerMainWindow((*reinterpret_cast< std::add_pointer_t<Player*>>(_a[1]))); break;
        case 1: _t->SignalWaitAMinute(); break;
        case 2: _t->on_startButton_clicked(); break;
        case 3: _t->on_pushButton_clicked(); break;
        case 4: _t->on_settingsButton_clicked(); break;
        case 5: _t->on_playerButton_clicked(); break;
        case 6: _t->takeCurrentXY((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2]))); break;
        case 7: _t->takeFieldSize((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[2]))); break;
        case 8: _t->takePlayer((*reinterpret_cast< std::add_pointer_t<Player>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<std::string>>(_a[2]))); break;
        case 9: _t->takeAttemptsFromField((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 10: _t->takeSignalNext((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 11: _t->takeSignalMakeNewField((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        case 12: _t->takePlayerOrSettings((*reinterpret_cast< std::add_pointer_t<bool>>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (MainWindow::*)(Player * );
            if (_t _q_method = &MainWindow::SignalPlayerMainWindow; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (MainWindow::*)();
            if (_t _q_method = &MainWindow::SignalWaitAMinute; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 1;
                return;
            }
        }
    }
}

const QMetaObject *MainWindow::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *MainWindow::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_CLASSMainWindowENDCLASS.stringdata0))
        return static_cast<void*>(this);
    return QMainWindow::qt_metacast(_clname);
}

int MainWindow::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 13)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 13;
    }
    return _id;
}

// SIGNAL 0
void MainWindow::SignalPlayerMainWindow(Player * _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void MainWindow::SignalWaitAMinute()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}
QT_WARNING_POP
