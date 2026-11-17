#!/bin/bash
mkdir -p ~/lab0 && cd ~/lab0 || exit 1

mkdir -p claude_monet/kitchen/hot_station claude_monet/kitchen/cold_station claude_monet/freezer claude_monet/pantry claude_monet/chef_office claude_monet/staff_room

echo -e "Говядина для фирменного блюда получена\nСеня проверил мясо перед сменой\nОдна упаковка колбасок оставлена на завтра" > claude_monet/kitchen/hot_station/senya_inventory
echo -e "Телятина для шефа\nФарш для котлет\nКурица для банкета\nЗаказ должен принять Сеня" > claude_monet/kitchen/hot_station/meat_order
echo -e "Сибас доставлен утром\nФедя проверил рыбный холодильник\nДорадо осталось четыре штуки" > claude_monet/kitchen/cold_station/fedya_inventory
echo -e "Лосось для холодной закуски\nТунец для специального заказа\nРыбные продукты передать Феде" > claude_monet/kitchen/cold_station/fish_order
echo -e "Две утки для блюда Баринова\nКоробка замороженных овощей\nЗапас мяса для большой компании" > claude_monet/freezer/reserve_list
echo -e "Пропала упаковка дорогих колбасок\nНе найден сыр из новой поставки\nСеня и Федя обещали всё объяснить\nБаринов требует отчёт до открытия" > claude_monet/pantry/missing_products
echo -e "Сеня снова устроил розыгрыш на кухне\nФедя помог спрятать продукты\nЛёва должен проверить оба цеха\nШеф ждёт объяснительные после смены" > claude_monet/chef_office/barinov_report
echo -e "Переставить коробки в кладовой\nСказать Лёве что поставку отменили\nУспеть всё вернуть до прихода Баринова" > claude_monet/staff_room/prank_plan
echo -e "Лёва заметил беспорядок в кладовой\nЗаписи с кухни переданы шефу\nСеня и Федя останутся после смены" > claude_monet/staff_room/leva_warning
echo -e "Вечерняя смена началась спокойно\nНа кухне обнаружилась пропажа продуктов\nБаринов вызвал Сеню и Федю в кабинет" > evening_incident

chmod u=rwx,g=rx,o=rx claude_monet
chmod 750 claude_monet/kitchen
chmod u=rwx,g=rwx,o= claude_monet/kitchen/hot_station
chmod 640 claude_monet/kitchen/hot_station/senya_inventory
chmod u=rw,g=r,o=r claude_monet/kitchen/hot_station/meat_order
chmod 750 claude_monet/kitchen/cold_station
chmod u=rw,g=r,o= claude_monet/kitchen/cold_station/fedya_inventory
chmod 644 claude_monet/kitchen/cold_station/fish_order
chmod u=rwx,g=rx,o= claude_monet/freezer
chmod 600 claude_monet/freezer/reserve_list
chmod 750 claude_monet/pantry
chmod u=rw,g=r,o= claude_monet/pantry/missing_products
chmod 710 claude_monet/chef_office
chmod u=r,g=r,o= claude_monet/chef_office/barinov_report
chmod u=rwx,g=rx,o= claude_monet/staff_room
chmod 600 claude_monet/staff_room/prank_plan
chmod u=r,g=r,o= claude_monet/staff_room/leva_warning
chmod 644 evening_incident

cp claude_monet/chef_office/barinov_report claude_monet/staff_room/shift_order
cp -r claude_monet/kitchen/cold_station claude_monet/staff_room/cold_backup
ln -s ../pantry/missing_products claude_monet/chef_office/product_loss
ln -s claude_monet/kitchen kitchen_work
ln evening_incident claude_monet/kitchen/incident_copy
cat claude_monet/kitchen/hot_station/senya_inventory claude_monet/kitchen/cold_station/fedya_inventory > claude_monet/kitchen/total_inventory
cat claude_monet/staff_room/leva_warning >> evening_incident
mv claude_monet/staff_room/prank_plan claude_monet/chef_office/senya_explanation

ls -lR | grep '^-' | grep -v '_copy$' | sort -nk5 | tail -n 4
grep -RhiE 'сеня|федя' . | grep -v 'Баринов' | sort | head -n 6
grep -rl 'рыб' claude_monet/kitchen/cold_station claude_monet/staff_room/cold_backup | wc -l
tail -q -n 2 claude_monet/kitchen/hot_station/*_inventory claude_monet/kitchen/cold_station/*_inventory | grep -iE 'проверил|оста' | sort -r
grep -vE 'Сеня|Федя' claude_monet/kitchen/total_inventory | sort -r | head -n 3 | wc -w
ls -lR | grep '^l' | sort -rk9
grep -hiE 'кух|шеф' claude_monet/chef_office/barinov_report claude_monet/staff_room/shift_order claude_monet/staff_room/leva_warning | grep -vi 'после' | sort -r | wc -w

rm -f claude_monet/chef_office/barinov_report
rm -f claude_monet/chef_office/product_loss
rm -f kitchen_work
rm -f evening_incident
rm -f claude_monet/kitchen/incident_copy
rm -f claude_monet/freezer/reserve_list
rmdir claude_monet/freezer
rm -rf claude_monet/staff_room/cold_backup