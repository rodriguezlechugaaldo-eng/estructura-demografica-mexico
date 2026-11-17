# Resultados de validación — Módulo 01

**Proyecto:** Estructura demográfica de México  
**Módulo:** 01. Importación, exploración y validación de datos  
**Fuente de datos:** Censo de Población y Vivienda 2020, Instituto Nacional de Estadística y Geografía (INEGI)  
**Archivo de origen:** `datos/originales/Poblacion_01.xlsx`  
**Script:** `codigo/01_importacion_validacion.R`  
**Software:** R 4.6.2  
**Fecha de ejecución documentada:** 17 de noviembre de 2026  
**Estado:** Aprobado en las comprobaciones de consistencia interna y reproducibilidad efectuadas.

## 1. Propósito

Documentar la importación, estructura, consistencia aritmética y reproducibilidad computacional del tabulado censal utilizado en el proyecto. Este registro se basa en las salidas obtenidas durante la ejecución del script en RStudio.

El control realizado **no equivale a una auditoría integral del levantamiento censal**, ni acredita por sí solo la exactitud sustantiva de cada observación. Verifica las propiedades y relaciones aritméticas explícitamente evaluadas.

## 2. Estructura de los datos

| Característica | Resultado |
|---|---:|
| Año de referencia | 2020 |
| Registros agregados | 759 |
| Variables | 5 |
| Unidades geográficas | 33 (32 entidades y agregado nacional) |
| Categorías de edad por unidad geográfica | 23 |
| Registros excluyendo la categoría «Total» | 726 |
| Registros estatales excluyendo el agregado nacional y «Total» | 704 |
| Categorías de edad comparadas a escala nacional, sin «Total» | 22 |

**Variables importadas:** `entidad`, `grupo_edad`, `poblacion_total`, `hombres` y `mujeres`.

**Unidad de registro:** combinación de unidad geográfica y categoría de edad; no corresponde a personas individuales. El agregado nacional y las filas «Total» no deben sumarse junto con sus componentes.

## 3. Resultados de las validaciones

| Comprobación | Resultado observado | Dictamen |
|---|---|---|
| Estructura: dimensiones, territorios y categorías | `TRUE` | Aprobada |
| Valores faltantes (`NA`) y duplicados por entidad y grupo | `TRUE`; 0 faltantes y 0 duplicados | Aprobada |
| Recuentos no negativos y total = hombres + mujeres | `TRUE`; 0 inconsistencias | Aprobada |
| Suma de categorías de edad por territorio frente a «Total» | `TRUE`; 0 diferencias | Aprobada |
| Suma de las 32 entidades frente al agregado nacional | `TRUE`; 0 diferencias | Aprobada |
| Suma estatal frente al total nacional de cada grupo de edad | `TRUE`; 0 diferencias | Aprobada |
| Integración de las seis comprobaciones | `TRUE` | Aprobada |

La comprobación de faltantes se refiere a valores `NA` en R. **«No especificado» es una categoría censal válida en el archivo**, no un valor faltante de R; su tratamiento en los indicadores deberá justificarse separadamente.

## 4. Comprobación de los totales nacionales

| Indicador | Total publicado en el tabulado | Suma de 32 entidades | Diferencia |
|---|---:|---:|---:|
| Población total | 126 014 024 | 126 014 024 | 0 |
| Hombres | 61 473 390 | 61 473 390 | 0 |
| Mujeres | 64 540 634 | 64 540 634 | 0 |

Se verificó, además, la igualdad entre sumas estatales y el registro nacional para las 22 categorías de edad distintas de «Total», tanto en población total como en hombres y mujeres.

## 5. Exportación y reproducibilidad

Se generaron los siguientes archivos:

- `datos/procesados/poblacion_mexico_2020_validada.csv`
- `datos/procesados/poblacion_mexico_2020_validada.rds`

La ejecución integral del script desde una sesión reiniciada de R produjo las siguientes comprobaciones satisfactorias:

| Control | Resultado |
|---|---|
| `validacion_final` | `TRUE` |
| Existencia del CSV | `TRUE` |
| Existencia del RDS | `TRUE` |
| Identidad del objeto importado y del RDS recuperado | `TRUE` |
| `reproduccion_correcta` | `TRUE` |

La comparación con `identical()` se efectuó sobre el objeto de R y su versión recuperada del archivo RDS. **No constituye por sí sola una verificación de equivalencia del archivo CSV tras una nueva importación.**

## 6. Decisiones metodológicas y límites

1. Se conserva el archivo Excel original sin modificaciones; las exportaciones se almacenan por separado.
2. Se preserva la categoría «No especificado» en la base validada.
3. Los totales del territorio «Estados Unidos Mexicanos» no se agregan a los totales estatales.
4. Las 759 filas son registros agregados; no permiten obtener exactamente todas las medidas de edad individual.
5. Las comparaciones confirmadas son de **consistencia interna** del tabulado, no estimaciones inferenciales ni pruebas de causalidad.
6. La reproducción se comprobó en el entorno de trabajo utilizado. Para reproducibilidad entre equipos queda pendiente documentar versiones de paquetes y, en su caso, fijar dependencias.

## 7. Referencias (APA 7)

Instituto Nacional de Estadística y Geografía. (2021). *En México somos 126 014 024 habitantes: Censo de Población y Vivienda 2020* (Comunicado de prensa núm. 24/21). https://www.inegi.org.mx/Contenidos/Saladeprensa/Boletines/2021/Estsociodemo/Resultcenso2020_Nal.Pdf

Instituto Nacional de Estadística y Geografía. (s. f.). *Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020* [Tabulado interactivo]. https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_e60cd8cf-927f-4b94-823e-972457a12d4b

---

**Próxima actividad:** registrar este informe junto con el script, los datos procesados y el proyecto de RStudio mediante Git; después revisar el commit antes de publicarlo en GitHub.
