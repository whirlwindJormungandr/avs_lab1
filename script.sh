#!/bin/bash

# ==========================================
# ЛАБОРАТОРНАЯ РАБОТА 1. ВАРИАНТ 2.
# ==========================================

cd ~

# --- ЧАСТЬ 1: СОЗДАНИЕ ДЕРЕВА И ПРАВА ---
mkdir -p ~/lab0/claude_monet/kitchen/hot_station ~/lab0/claude_monet/kitchen/cold_station ~/lab0/claude_monet/freezer ~/lab0/claude_monet/pantry ~/lab0/claude_monet/chef_office ~/lab0/claude_monet/staff_room

touch ~/lab0/claude_monet/kitchen/hot_station/senya_inventory
touch ~/lab0/claude_monet/kitchen/hot_station/meat_order
touch ~/lab0/claude_monet/kitchen/cold_station/fedya_inventory
touch ~/lab0/claude_monet/kitchen/cold_station/fish_order
touch ~/lab0/claude_monet/freezer/reserve_list
touch ~/lab0/claude_monet/pantry/missing_products
touch ~/lab0/claude_monet/chef_office/barinov_report
touch ~/lab0/claude_monet/staff_room/prank_plan
touch ~/lab0/claude_monet/staff_room/leva_warning
touch ~/lab0/evening_incident

echo -e "Говядина для фирменного блюда получена\nСеня проверил мясо перед сменой\nОдна упаковка колбасок оставлена на завтра" > ~/lab0/claude_monet/kitchen/hot_station/senya_inventory
echo -e "Телятина для шефа\nФарш для котлет\nКурица для банкета\nЗаказ должен принять Сеня" > ~/lab0/claude_monet/kitchen/hot_station/meat_order
echo -e "Сибас доставлен утром\nФедя проверил рыбный холодильник\nДорадо осталось четыре штуки" > ~/lab0/claude_monet/kitchen/cold_station/fedya_inventory
echo -e "Лосось для холодной закуски\nТунец для специального заказа\nРыбные продукты передать Феде" > ~/lab0/claude_monet/kitchen/cold_station/fish_order
echo -e "Две утки для блюда Баринова\nКоробка замороженных овощей\nЗапас мяса для большой компании" > ~/lab0/claude_monet/freezer/reserve_list
echo -e "Пропала упаковка дорогих колбасок\nНе найден сыр из новой поставки\nСеня и Федя обещали всё объяснить\nБаринов требует отчёт до открытия" > ~/lab0/claude_monet/pantry/missing_products
echo -e "Сеня снова устроил розыгрыш на кухне\nФедя помог спрятать продукты\nЛёва должен проверить оба цеха\nШеф ждёт объяснительные после смены" > ~/lab0/claude_monet/chef_office/barinov_report
echo -e "Переставить коробки в кладовой\nСказать Лёве что поставку отменили\nУспеть всё вернуть до прихода Баринова" > ~/lab0/claude_monet/staff_room/prank_plan
echo -e "Лёва заметил беспорядок в кладовой\nЗаписи с кухни переданы шефу\nСеня и Федя останутся после смены" > ~/lab0/claude_monet/staff_room/leva_warning
echo -e "Вечерняя смена началась спокойно\nНа кухне обнаружилась пропажа продуктов\nБаринов вызвал Сеню и Федю в кабинет" > ~/lab0/evening_incident

chmod u=rwx,g=rx,o=rx ~/lab0/claude_monet
chmod u=rwx,g=rwx,o= ~/lab0/claude_monet/kitchen/hot_station
chmod u=rw,g=r,o=r ~/lab0/claude_monet/kitchen/hot_station/meat_order
chmod u=rw,g=r,o= ~/lab0/claude_monet/kitchen/cold_station/fedya_inventory
chmod u=rwx,g=rx,o= ~/lab0/claude_monet/freezer
chmod u=rw,g=r,o= ~/lab0/claude_monet/pantry/missing_products
chmod u=r,g=r,o= ~/lab0/claude_monet/chef_office/barinov_report
chmod u=rwx,g=rx,o= ~/lab0/claude_monet/staff_room
chmod u=r,g=r,o= ~/lab0/claude_monet/staff_room/leva_warning

chmod 750 ~/lab0/claude_monet/kitchen
chmod 640 ~/lab0/claude_monet/kitchen/hot_station/senya_inventory
chmod 750 ~/lab0/claude_monet/kitchen/cold_station
chmod 644 ~/lab0/claude_monet/kitchen/cold_station/fish_order
chmod 600 ~/lab0/claude_monet/freezer/reserve_list
chmod 750 ~/lab0/claude_monet/pantry
chmod 710 ~/lab0/claude_monet/chef_office
chmod 600 ~/lab0/claude_monet/staff_room/prank_plan
chmod 644 ~/lab0/evening_incident


# --- ЧАСТЬ 2: КОПИРОВАНИЕ И ССЫЛКИ ---
cp ~/lab0/claude_monet/chef_office/barinov_report ~/lab0/claude_monet/staff_room/shift_order
cp -r ~/lab0/claude_monet/kitchen/cold_station ~/lab0/claude_monet/staff_room/cold_backup

cd ~/lab0/claude_monet/chef_office
ln -s ../pantry/missing_products product_loss
cd ~/lab0

ln -s claude_monet/kitchen kitchen_work
ln ~/lab0/evening_incident ~/lab0/claude_monet/kitchen/incident_copy

cat ~/lab0/claude_monet/kitchen/hot_station/senya_inventory ~/lab0/claude_monet/kitchen/cold_station/fedya_inventory > ~/lab0/claude_monet/kitchen/total_inventory
cat ~/lab0/claude_monet/staff_room/leva_warning >> ~/lab0/evening_incident
mv ~/lab0/claude_monet/staff_room/prank_plan ~/lab0/claude_monet/chef_office/senya_explanation


# --- ЧАСТЬ 3: ПОИСК И ФИЛЬТРАЦИЯ ---
echo "--- Поиск 1 ---"
ls -lR ~/lab0 | grep "^-" | grep -v "_copy" | sort -k5 -n | tail -n 4

echo "--- Поиск 2 ---"
grep -rhiE "сеня|федя" ~/lab0 | grep -iv "Баринов" | sort | head -n 6

echo "--- Поиск 3 ---"
grep -rli "рыб" ~/lab0/claude_monet/kitchen/cold_station ~/lab0/claude_monet/staff_room/cold_backup | wc -l

echo "--- Поиск 4 ---"
tail -q -n 2 ~/lab0/claude_monet/kitchen/hot_station/senya_inventory ~/lab0/claude_monet/kitchen/cold_station/fedya_inventory | grep -iE "проверил|оста" | sort -r

echo "--- Поиск 5 ---"
grep -ivE "Сеня|Федя" ~/lab0/claude_monet/kitchen/total_inventory | sort -r | head -n 3 | wc -w

echo "--- Поиск 6 ---"
ls -lR ~/lab0 | grep "^l" | sort -k9 -r

echo "--- Поиск 7 ---"
grep -hiE "кух|шеф" ~/lab0/claude_monet/chef_office/barinov_report ~/lab0/claude_monet/staff_room/shift_order ~/lab0/claude_monet/staff_room/leva_warning | grep -iv "после" | sort -r | wc -w


# --- ЧАСТЬ 4: УДАЛЕНИЕ ---
rm -f ~/lab0/claude_monet/chef_office/barinov_report
rm -f ~/lab0/claude_monet/chef_office/product_loss
rm -f ~/lab0/kitchen_work
rm -f ~/lab0/evening_incident
rm -f ~/lab0/claude_monet/kitchen/incident_copy
rm -f ~/lab0/claude_monet/freezer/reserve_list
rmdir ~/lab0/claude_monet/freezer
rm -rf ~/lab0/claude_monet/staff_room/cold_backup

echo "Скрипт успешно выполнен!"
