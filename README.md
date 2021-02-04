# diaversario

App simples para calcular quantidade de dias de vida.

Para utiliza-lo basta inserir a data do nascimento como mostra a imagem:

![](www/app.gif)


# How to

Códigos para calcular as medidas:

- R :

```r
born  <- as.Date("1993-12-14") 
today <- Sys.Date()

# Quantos dias de vida
difftime(today, born)

# Completa 10.000 dias de vida em:
born+days(10000)

# Faltam
difftime(born+days(10000), today)
```

- Python: 

```python
from datetime import datetime, timedelta

today = datetime.today()
born = datetime.strptime('1993-12-14', '%Y-%m-%d')

# Quantos dias de vida
print("Time difference of", str((today-born).days), "days")

# Completa 10.000 dias de vida em:
str(born + timedelta(days=10000))

# Faltam
print("Time difference of",str((born + timedelta(days=10000) - today).days), "days")
```


