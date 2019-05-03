-- 숫자형 함수alter
select abs(1), abs(-1);
select mod(234, 10), 234 % 10;
select floor(1.2345), floor(-1.2345), ceil(1.2345), ceil(-1.2345); -- ceiling도 가능
select round(-1.23), round(-1.58), round(1.58), round(1.298, 1);
select pow(2, 10);
select sign(-10), sign(10), sign(0);
select sin(-10), sin(10), sin(0);
select greatest(98, 60, 30), greatest('a', 'b', 'cb', 'ca');
select least(98, 60, 30), least('b', 'a', 'cb', 'ca');



