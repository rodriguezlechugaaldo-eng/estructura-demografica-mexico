# Diccionario de variables

**Proyecto:** Estructura demográfica de México  
**Fuente:** Censo de Población y Vivienda 2020, INEGI  
**Archivo original:** `datos/originales/Poblacion_01.xlsx`  
**Hoja:** `Tabulado`  
**Cobertura:** Estados Unidos Mexicanos y 32 entidades federativas  
**Año de referencia:** 2020  
**Estado del documento:** Versión inicial, elaborada antes del procesamiento en R

## 1. Propósito y alcance

Este documento identifica las variables del tabulado original, sus categorías, unidades de medida, reglas de validación y transformaciones previstas. Su finalidad es evitar interpretaciones incorrectas, dobles conteos y operaciones estadísticas incompatibles con la naturaleza **agregada** de los datos.

El tabulado contiene **759 registros**, correspondientes a **33 ámbitos geográficos × 23 categorías de edad**. Cada registro es una combinación de **territorio y categoría de edad**, con tres recuentos de personas: total, hombres y mujeres. **No contiene registros individuales de personas.**

El archivo consultado se refiere al **15 de marzo de 2020**, según la nota metodológica incluida en la hoja. La fecha de descarga o consulta **no** es una segunda fecha de referencia censal.

## 2. Ubicación de los datos en Excel

| Elemento | Ubicación / descripción |
|---|---|
| Hoja de trabajo | `Tabulado` |
| Metadatos y encabezados | Filas 1–7 |
| Encabezados estadísticos | Filas 6 y 7 |
| Datos analíticos | `A8:E766` |
| Notas y fuentes | Filas posteriores a la 766 |
| Variables originales | Columnas A, B, C, D y E |

La fila 6 identifica el año **2020** para las columnas de población y la fila 7 distingue **Total**, **Hombres** y **Mujeres**. Al importar el archivo en R, no deben tratarse las filas de metadatos y notas como observaciones poblacionales.

## 3. Variables originales

| Columna en Excel | Nombre propuesto en R | Definición operativa | Tipo estadístico | Tipo de dato en R | Unidad / dominio |
|---|---|---|---|---|---|
| A | `entidad` | Denominación geográfica publicada en el tabulado | Cualitativa nominal | `character` | `Estados Unidos Mexicanos` y nombres de las 32 entidades federativas |
| B | `grupo_edad` | Clasificación de la población por grupo quinquenal de edad | Cualitativa ordinal para grupos de edad; contiene también dos categorías especiales | `character` inicialmente; `factor` ordenado para intervalos de edad | 21 intervalos de edad, `No especificado` y `Total` |
| C | `poblacion_total` | Número de personas de ambos sexos en la celda geográfica y etaria | Cuantitativa discreta, recuento agregado | Numérico entero o numérico exacto para estos valores | Personas, enteros ≥ 0 |
| D | `hombres` | Número de hombres contabilizados en la celda | Cuantitativa discreta, recuento agregado | Numérico entero o numérico exacto | Personas, enteros ≥ 0 |
| E | `mujeres` | Número de mujeres contabilizadas en la celda | Cuantitativa discreta, recuento agregado | Numérico entero o numérico exacto | Personas, enteros ≥ 0 |

**Importante:** el tabulado original **no** tiene una columna llamada `sexo`. «Total», «Hombres» y «Mujeres» son encabezados de tres columnas numéricas. Si se transforma a formato largo, la variable `sexo` será **derivada**, no original. Además, «Total» no debe combinarse con hombres y mujeres como si fuera una tercera categoría de sexo en un mismo cálculo.

Tampoco existe una clave numérica de entidad federativa en las columnas A–E, ni una variable de edad exacta en años cumplidos.

## 4. Dominio exacto de `grupo_edad`

| Orden para el análisis | Categoría original | Interpretación |
|---:|---|---|
| — | `Total` | Subtotal de la entidad o del agregado nacional: **no es un intervalo de edad** |
| 1 | `0 a 4 años` | Edad 0–4 |
| 2 | `5 a 9 años` | Edad 5–9 |
| 3 | `10 a 14 años` | Edad 10–14 |
| 4 | `15 a 19 años` | Edad 15–19 |
| 5 | `20 a 24 años` | Edad 20–24 |
| 6 | `25 a 29 años` | Edad 25–29 |
| 7 | `30 a 34 años` | Edad 30–34 |
| 8 | `35 a 39 años` | Edad 35–39 |
| 9 | `40 a 44 años` | Edad 40–44 |
| 10 | `45 a 49 años` | Edad 45–49 |
| 11 | `50 a 54 años` | Edad 50–54 |
| 12 | `55 a 59 años` | Edad 55–59 |
| 13 | `60 a 64 años` | Edad 60–64 |
| 14 | `65 a 69 años` | Edad 65–69 |
| 15 | `70 a 74 años` | Edad 70–74 |
| 16 | `75 a 79 años` | Edad 75–79 |
| 17 | `80 a 84 años` | Edad 80–84 |
| 18 | `85 a 89 años` | Edad 85–89 |
| 19 | `90 a 94 años` | Edad 90–94 |
| 20 | `95 a 99 años` | Edad 95–99 |
| 21 | `100 años y más` | Intervalo superior **abierto**: sin edad máxima identificable |
| — | `No especificado` | Edad no clasificada en alguno de los intervalos anteriores |

Las categorías `Total` y `No especificado` se conservarán en la base original y se tratarán de forma expresa durante los cálculos. No se asignará un punto medio a `100 años y más` sin un supuesto metodológico explícito.

## 5. Variables derivadas previstas (aún no creadas)

| Variable propuesta | Regla de construcción | Tipo / unidad | Observación |
|---|---|---|---|
| `anio` | Asignar `2020` después de verificar los encabezados | Entero, año | Constante derivada de metadatos, no una columna original |
| `ambito` | `nacional` si `entidad == "Estados Unidos Mexicanos"`; en otro caso, `estatal` | Categoría | Impide mezclar el agregado nacional con las entidades |
| `es_total_edad` | Verdadero si `grupo_edad == "Total"` | Lógico | Excluir subtotales al sumar intervalos |
| `edad_no_especificada` | Verdadero si `grupo_edad == "No especificado"` | Lógico | Documentar inclusiones y exclusiones |
| `orden_edad` | Orden 1–21 de intervalos de edad | Entero | No asignar orden numérico a `Total` o `No especificado` |
| `grupo_amplio_edad` | `0–14`, `15–64` o `65 y más`, según la pertenencia de cada grupo completo | Categoría | Se aplica solo a intervalos de edad especificada |
| `sexo` | Transformación opcional de columnas `hombres` y `mujeres` a formato largo | Categoría nominal | Contendrá únicamente `Hombres` y `Mujeres` en una tabla sin subtotales adicionales |
| `personas` | Valor de `hombres` o `mujeres` tras la transformación a formato largo | Recuento, personas | Evitar duplicarlo con `poblacion_total` |

Las denominaciones son propuestas de trabajo. Se documentará cualquier cambio antes de procesar o publicar bases derivadas.

## 6. Indicadores estadísticos y demográficos previstos

| Indicador | Fórmula / criterio general | Denominador o advertencia |
|---|---|---|
| Población por sexo | Conteos de `hombres` y `mujeres` en el registro `Total` del territorio | No sumar el `Total` con las filas de edades |
| Porcentaje de mujeres | `100 × mujeres / poblacion_total` | Para el registro `Total` de cada territorio |
| Porcentaje de hombres | `100 × hombres / poblacion_total` | Para el registro `Total` de cada territorio |
| Relación hombres-mujeres | `100 × hombres / mujeres` | Hombres por cada 100 mujeres; verificar denominador distinto de cero |
| Participación de un intervalo de edad | `100 × personas del intervalo / población de referencia` | Especificar si la referencia es población total o población con edad especificada |
| Población de 0–14 años | Suma de 0–4, 5–9 y 10–14 | Excluir `Total` y `No especificado` |
| Población de 15–64 años | Suma de los diez intervalos quinquenales de 15–19 a 60–64 | Excluir `Total` y `No especificado` |
| Población de 65 años y más | Suma de los intervalos desde 65–69 hasta 100 años y más | Incluye la categoría abierta |
| Razón de dependencia demográfica | `100 × (población 0–14 + población 65 y más) / población 15–64` | Indicador de estructura por edades; **no mide dependencia económica efectiva** |

En todos los indicadores se registrarán el territorio, los grupos de edad incluidos, los conteos de referencia, la fórmula aplicada y el tratamiento de edad no especificada. Se conservará la precisión de cálculo y se mostrarán **cuatro decimales** cuando proceda.

La **edad media, la varianza de edades individuales, la desviación estándar individual y los cuantiles exactos de edad** no son recuperables a partir de estos grupos quinquenales. Su eventual estimación requerirá supuestos y una explicación separada de la precisión y de las limitaciones. En particular, el intervalo `100 años y más` es abierto.

## 7. Reglas de validación que implementaremos en R

1. **Número de filas:** 759 registros de datos (`A8:E766`), sin considerar encabezados ni notas.
2. **Cobertura:** 33 denominaciones geográficas distintas: total nacional más 32 entidades.
3. **Grupos de edad:** 23 categorías por cada territorio, sin duplicados en la clave compuesta `entidad + grupo_edad`.
4. **Tipo y rango:** `poblacion_total`, `hombres` y `mujeres` deben contener conteos enteros no negativos y sin celdas numéricas vacías.
5. **Identidad por fila:** `poblacion_total = hombres + mujeres`.
6. **Identidad territorial:** la suma de los 21 intervalos de edad más `No especificado` debe coincidir con el registro `Total` de cada territorio.
7. **Identidad geográfica:** la suma de los registros `Total` de las 32 entidades debe coincidir con el registro `Total` de `Estados Unidos Mexicanos`.
8. **No duplicación:** no sumar `Estados Unidos Mexicanos` con las entidades ni sumar una fila `Total` con sus desgloses por edad.
9. **Conservación:** no modificar `datos/originales/Poblacion_01.xlsx`; guardar cualquier transformación en `datos/procesados/`.
10. **Trazabilidad:** registrar código, mensajes de validación y decisiones de transformación.

### Cifras de referencia para las validaciones

El archivo original presenta los siguientes valores para `Estados Unidos Mexicanos`:

| `grupo_edad` | `poblacion_total` | `hombres` | `mujeres` |
|---|---:|---:|---:|
| `Total` | 126 014 024 | 61 473 390 | 64 540 634 |
| `No especificado` | 273 386 | 136 194 | 137 192 |

Estos valores son **referencias extraídas del archivo original**, no resultados de scripts que ya se hayan ejecutado en el repositorio.

## 8. Precaución sobre información censal estimada

El archivo incluye una nota para 2020 que menciona **6 337 751 personas estimadas en 1 588 422 viviendas sin información de ocupantes**. Es una nota de la fuente censal que se conservará en la documentación; **no debe equipararse** de manera automática a la categoría `No especificado` de edad (273 386 personas en el agregado nacional).

## 9. Referencia bibliográfica (APA 7)

Instituto Nacional de Estadística y Geografía. (s. f.). *Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020* [Tabulado interactivo]. Recuperado el 17 de noviembre de 2026, de https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e

**Fuente empírica exacta revisada:** archivo `Poblacion_01.xlsx`, hoja `Tabulado`; fecha de consulta consignada en el propio archivo: 17/11/2026 04:03:34.
