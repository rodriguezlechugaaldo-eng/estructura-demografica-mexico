# Fuentes estadísticas del proyecto

## 1. Identificación de la fuente principal

| Elemento | Descripción |
|---|---|
| Institución responsable | Instituto Nacional de Estadística y Geografía (INEGI) |
| Operación estadística | Censo de Población y Vivienda 2020 |
| Recurso consultado | *Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020* |
| Año seleccionado en el tabulado | 2020 |
| Fecha de consulta indicada en el archivo | 17 de noviembre de 2026, 04:03:34 |
| Archivo original | `datos/originales/Poblacion_01.xlsx` |
| Hoja | `Tabulado` |
| Intervalo con observaciones | `A8:E766` |
| Cobertura territorial | Estados Unidos Mexicanos y las 32 entidades federativas |
| Nivel de desagregación | Territorio × grupo quinquenal de edad; recuentos por sexo |
| Unidad de medida | Personas |
| Naturaleza de la información | Tabulado agregado, no microdatos individuales |
| Sitio de consulta | https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e |

**Regla de conservación:** el archivo original se mantiene sin alteraciones. Toda limpieza o transformación se realizará mediante scripts de R y se guardará por separado en `datos/procesados/`.

## 2. Organización del archivo original

La hoja `Tabulado` incluye información institucional y fecha de consulta en sus primeras filas; los encabezados de las variables se encuentran en las filas 6 y 7. Las observaciones de interés ocupan las filas 8 a 766. Debajo de ellas aparecen notas y fuentes de la serie censal.

En la descarga examinada existen **759 registros**: **33 agregados geográficos** (el total nacional y 32 entidades federativas) por **23 categorías de edad** (20 intervalos quinquenales de 0–4 a 95–99 años, 100 años y más, No especificado y Total).

| Columna original | Contenido | Tipo esperado al procesar |
|---|---|---|
| A | Entidad federativa | Texto/categoría |
| B | Grupo quinquenal de edad | Texto/categoría ordenada |
| C | Población total en 2020 | Número entero |
| D | Hombres en 2020 | Número entero |
| E | Mujeres en 2020 | Número entero |

**Precisión:** «Total» en la columna de edad es un subtotal del territorio y **no** debe sumarse otra vez a las edades específicas. «Estados Unidos Mexicanos» es el agregado nacional y **no** debe sumarse junto a las 32 entidades para reconstruir la población del país.

## 3. Comprobaciones preliminares de consistencia

Se revisó el archivo recibido para documentar su estructura y coherencia aritmética. Las siguientes comprobaciones se refieren únicamente al tabulado descargado, no a la evaluación integral de la calidad censal.

| Comprobación | Resultado en el archivo revisado |
|---|---|
| Registros de datos | 759 |
| Entidades federativas | 32 |
| Agregado nacional adicional | 1 |
| Categorías de edad por territorio | 23 |
| Total = hombres + mujeres | Se cumple en los 759 registros |
| Suma de los totales estatales = total nacional | Se cumple |

Para el agregado nacional, la fila «Total» consigna **126 014 024 personas**, de las cuales **61 473 390 son hombres** y **64 540 634 son mujeres**. La fila «No especificado» en edad contabiliza **273 386 personas**; se conservará como categoría independiente y se documentará su tratamiento en cada indicador.

Las cifras anteriores son **datos de referencia para la validación**, no resultados de análisis producidos todavía por los scripts del proyecto.

## 4. Notas metodológicas y restricciones

1. **Tabulados, no personas individuales.** Cada registro corresponde a una combinación territorial y de categoría de edad; las columnas numéricas son conteos poblacionales.
2. **Categoría de edad no especificada.** No se redistribuirá automáticamente. Cualquier exclusión de denominadores debe indicarse y justificarse.
3. **Categoría abierta.** «100 años y más» no tiene un límite superior definido. No se asignará una edad puntual sin hipótesis explícita.
4. **Medidas de edad individual.** La media, varianza, desviación estándar y cuantiles individuales no pueden recuperarse exactamente a partir de estos datos agrupados. Si se calculan aproximaciones, se explicitarán su procedimiento y limitaciones.
5. **Indicadores de dependencia.** Los cortes etarios utilizados se definirán antes de calcular las razones, y se diferenciarán de la dependencia económica efectiva.
6. **Agregados geográficos.** Se separarán las comparaciones entre entidades y el total nacional para prevenir dobles conteos.
7. **Estadística descriptiva.** Las distribuciones observadas no permiten identificar, por sí solas, causas económicas, políticas o sociales.
8. **Nota censal incluida en la descarga.** Para 2020, el tabulado declara que la información se refiere al **15 de marzo** e incluye una estimación de **6 337 751 personas** correspondiente a **1 588 422 viviendas sin información de ocupantes**. Esa nota no es equivalente a la categoría «No especificado» de la variable edad.

## 5. Tratamiento previsto en R

El primer script (`codigo/01_importacion.R`) deberá:

1. Leer el archivo Excel desde `datos/originales/` sin modificarlo.
2. Identificar expresamente la hoja `Tabulado` y las filas que contienen las observaciones.
3. Asignar nombres de variables en español, sin espacios ni acentos, por ejemplo: `entidad`, `grupo_edad`, `poblacion_total`, `hombres` y `mujeres`.
4. Revisar tipos de variables, etiquetas y posibles valores faltantes.
5. Verificar las identidades aritméticas y distinguir agregados de categorías desglosadas.
6. Crear, solamente después de validar, un archivo de trabajo en `datos/procesados/`.
7. Guardar los resultados de las comprobaciones de manera reproducible.

Los procedimientos exactos y sus decisiones se desarrollarán en `documentacion/protocolo_metodologico.md` y `documentacion/diccionario_variables.md`.

## 6. Referencia bibliográfica (APA 7)

Instituto Nacional de Estadística y Geografía. (s. f.). *Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020* [Tabulado interactivo]. Recuperado el 17 de noviembre de 2026, de https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e

**Nota bibliográfica:** la fecha de consulta del archivo no equivale a la fecha de publicación del tabulado. Por ello, mientras no se documente una fecha editorial específica del recurso interactivo, la referencia utiliza «s. f.» y fecha de recuperación.
