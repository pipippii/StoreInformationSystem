# Информационная система для магазина крупной торговой сети

Этот проект выполнен в рамках изучения предмета **SQL и Oracle PL/SQL**. Задание заключалось в создании информационной системы (ИС), которая обслуживает часть информационных потребностей магазина крупной торговой сети. В рамках данной системы обеспечиваются основные бизнес-процессы магазина, такие как поступление и движение товаров, установка цен, доступ персонала к управлению данными, а также обмен информацией с головной компанией.

## Описание системы

Система включает в себя несколько ключевых модулей, которые обеспечивают эффективное управление товарами и ценами в магазине, а также предоставление необходимой информации персоналу. Основные компоненты системы:

- **Учет поступления и движения товаров**: В системе реализована возможность регистрации поступлений товаров на склад и их перемещение внутри магазина. Все операции фиксируются в базе данных для обеспечения прозрачности и отслеживаемости.
- **Установка цен на товары**: Для каждого товара можно установить цену, которая будет автоматически обновляться в зависимости от изменений в базе данных.
- **Доступ персонала к данным**: Разработаны различные уровни доступа для персонала магазина, что позволяет разграничивать права на управление товарами, ценами и операциями в системе.
- **Справочная информация**: Система предоставляет справочные данные о товарах, ценах и наличии товаров в магазине, что помогает сотрудникам быстро находить необходимую информацию.
- **Обмен данными с головной компанией**: Обеспечен обмен информацией между магазином и головной компанией для обновления данных о товарах, ценах и движении товаров.

## Технологии

- **SQL**: Основной язык запросов для работы с данными в базе данных.
- **Oracle PL/SQL**: Для разработки хранимых процедур и триггеров, обеспечивающих бизнес-логику системы.
- **Oracle Database**: Система управления базами данных, использующаяся для хранения и управления данными.

## Архитектура системы

1. **База данных**: Включает таблицы для учета товаров, поставок, цен, сотрудников и операций.
2. **Программный интерфейс**: Используется для взаимодействия с базой данных, предоставляя пользователю удобные инструменты для ввода и обновления данных.
3. **Отчеты и запросы**: Реализованы запросы для получения аналитической информации, например, о движении товаров, продажах и остатках на складе.

## Основные функции

1. **Учет товаров**: Регистрация новых товаров, обновление их характеристик и отслеживание движения внутри магазина.
2. **Установка и изменение цен**: Возможность изменять цены товаров в зависимости от различных факторов (акции, скидки, изменения на складе).
3. **Управление персоналом**: Разграничение доступа сотрудников к различным частям системы в зависимости от их ролей (менеджеры, кассиры, складские работники).
4. **Отчеты по товарообороту**: Генерация отчетов о движении товаров, остатках на складе, продажах и прочее.
5. **Обмен с головной компанией**: Передача данных о товарных запасах и ценах в головной офис для централизованного контроля и планирования.

## Установка и настройка

Для работы с системой необходимо:

1. Установить **Oracle Database** (или использовать уже существующую базу данных).
2. Настроить подключение к базе данных с помощью инструментов Oracle.
3. Загрузить и применить SQL-скрипты для создания базы данных и таблиц.
4. Настроить хранимые процедуры и триггеры для выполнения бизнес-логики.
