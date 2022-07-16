-- Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.

SELECT DISTINCT pca.model,
                pcb.model,
                pca.speed,
                pca.ram
FROM   pc pca
       JOIN pc pcb
         ON ( pca.speed = pcb.speed
              AND pca.ram = pcb.ram )
WHERE  pca.model > pcb.model 

-- Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
-- Вывести: type, model, speed
SELECT DISTINCT type,
                laptop.model,
                speed
FROM   laptop
       JOIN product
         ON ( laptop.model = product.model )
WHERE  speed < ALL (SELECT speed
                    FROM   pc) 
-- Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
SELECT DISTINCT maker,
                price
FROM   product
       JOIN printer
         ON ( product.model = printer.model )
WHERE  printer.price = (SELECT Min(price)
                        FROM   printer
                        WHERE  printer.color = 'y')
       AND printer.color = 'y' 

-- 19(1)
-- Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
-- Вывести: maker, средний размер экрана.
SELECT maker,
       Avg(screen)
FROM   product
       JOIN laptop
         ON ( product.model = laptop.model )
GROUP  BY maker 

-- 20(2)
-- Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.
SELECT maker,
       Count(model)
FROM   product
WHERE  product.type = 'pc'
GROUP  BY maker
HAVING Count(model) >= 3 

-- Задание: 21 (Serge I: 2003-02-13)
-- Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
-- Вывести: maker, максимальная цена.
SELECT maker,
       Max(price)
FROM   product
       JOIN pc
         ON ( product.model = pc.model )
GROUP  BY maker 