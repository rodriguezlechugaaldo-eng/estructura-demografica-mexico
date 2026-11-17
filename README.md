# Estructura demográfica de México

**Análisis estadístico descriptivo de la población por edad y sexo con R**

**Nivel:** básico · **Área:** ciencias sociales · **Cobertura:** México y sus 32 entidades federativas · **Año de estudio:** 2020 · **Estado:** en desarrollo

## 1. Presentación del proyecto

Este repositorio desarrolla un análisis estadístico descriptivo de la estructura demográfica de México mediante **R**, utilizando información oficial del **Censo de Población y Vivienda 2020** del Instituto Nacional de Estadística y Geografía (INEGI).

El proyecto busca comprender la composición de la población por **edad y sexo**, organizar datos censales, construir indicadores y elaborar visualizaciones reproducibles. Está dirigido al aprendizaje de estadística aplicada a la **Economía, la Ciencia Política, las Políticas Públicas y la Economía Política**.

Aunque las técnicas computacionales serán inicialmente básicas, se documentarán las definiciones, las decisiones de procesamiento y los límites de interpretación de cada indicador.

## 2. Contexto demográfico de México

### 2.1. La demografía y el estudio de la población mexicana

La demografía estudia el tamaño, la estructura, la distribución y las transformaciones de las poblaciones humanas. En México, su desarrollo como campo científico ha estado ligado a la producción de información estadística y a la formulación de políticas de población. Welti-Chanes (2011) reconstruye esa trayectoria y explica la importancia del conocimiento demográfico para comprender las relaciones entre crecimiento poblacional y condiciones sociales.

Desde esta perspectiva, estudiar la composición por edad y sexo no significa únicamente contar habitantes. Permite describir características fundamentales de una sociedad e identificar diferencias relevantes para el análisis económico, político y territorial.

### 2.2. Transición demográfica y cambios en la estructura por edades

La población mexicana experimentó transformaciones importantes durante el siglo XX, vinculadas con la evolución de la mortalidad, la fecundidad y la migración. Partida Bush (2005) señala que las distintas etapas de la transición demográfica dejan huellas en la estructura por edades y contribuyen a explicar el proceso de envejecimiento poblacional.

Estos cambios no ocurrieron de manera uniforme. Benítez Zenteno (2002) analiza el carácter desigual de la transición demográfica mexicana, atendiendo a sus componentes poblacionales y a sus relaciones con la organización familiar, el desarrollo urbano y la política de población.

### 2.3. Características de la población en 2020

Según los resultados del Censo de Población y Vivienda 2020, en México residían **126 014 024 personas**: **64 540 634 mujeres (51,2 %)** y **61 473 390 hombres (48,8 %)**. La **edad mediana** fue de **29 años**, frente a **22 años en 2000** y **26 años en 2010** (INEGI, 2021c, pp. 1–2).

El INEGI (2023, pp. 1–3) describe una reducción del ritmo de crecimiento poblacional y cambios en la distribución por edades, visibles en el menor peso relativo de los grupos situados en la base de la pirámide poblacional. Estos datos ofrecen un punto de partida para caracterizar la estructura demográfica nacional sin confundir el análisis descriptivo de 2020 con una explicación causal de sus transformaciones históricas.

### 2.4. Diferencias territoriales

La distribución de la población también presenta diferencias importantes entre entidades federativas. La heterogeneidad territorial es pertinente para estudiar la composición por edades y sexo a distintas escalas. Desde el campo de los estudios urbanos, Sobrino (2024) documenta patrones diferenciados de dinámica demográfica y expansión territorial en ciudades mexicanas entre 1990 y 2020.

Este repositorio se concentra en la **comparación entre entidades federativas**, no en reproducir el análisis urbano de Sobrino. Su trabajo se utiliza como antecedente académico de la relevancia de la dimensión territorial.

### 2.5. Relevancia para las ciencias sociales

- **Economía:** la estructura por edades contextualiza el estudio de la población potencialmente vinculada al mercado laboral y de las necesidades de consumo y protección social.
- **Ciencia Política:** la composición demográfica proporciona contexto para investigaciones sobre representación, participación y distribución territorial de la población.
- **Políticas Públicas:** las diferencias por edad, sexo y territorio ayudan a describir poblaciones relevantes para la planeación de servicios educativos, sanitarios y de cuidados.
- **Economía Política:** la estructura poblacional puede contextualizar discusiones sobre transformaciones económicas, distribución de recursos y organización social.

Estas conexiones son **ámbitos posibles de interpretación**, no efectos causales identificados por el proyecto.

## 3. Planteamiento del problema

La estructura demográfica nacional puede resumirse mediante cifras agregadas, pero estas no muestran por sí solas cómo se distribuye la población entre grupos de edad y sexo ni cómo varía dicha composición entre entidades federativas. Para describir esas diferencias se requieren datos comparables, definiciones consistentes y procedimientos estadísticos verificables.

**Pregunta principal:** ¿Cómo se distribuye la población mexicana por edad y sexo y qué diferencias presenta su estructura demográfica entre las entidades federativas, según el Censo de Población y Vivienda 2020?

**Alcance:** estudio cuantitativo, transversal y descriptivo. No se formularán conclusiones causales a partir de asociaciones o diferencias entre grupos.

## 4. Objetivos

### Objetivo general

Analizar la estructura demográfica de México por edad y sexo mediante técnicas de estadística descriptiva implementadas en R, a partir de información censal oficial correspondiente a 2020.

### Objetivos específicos

1. Importar, inspeccionar y validar tabulados demográficos del INEGI.
2. Construir distribuciones de frecuencias absolutas y relativas por sexo y grupos de edad.
3. Calcular indicadores demográficos básicos, documentando sus fórmulas y denominadores.
4. Elaborar tablas, gráficos y pirámides poblacionales reproducibles.
5. Comparar indicadores descriptivos entre las 32 entidades federativas.
6. Distinguir los cálculos exactos de aquellos que exigirían microdatos o aproximaciones a partir de datos agrupados.
7. Interpretar los resultados desde las ciencias sociales sin exceder los límites de la evidencia disponible.

## 5. Delimitación

| Elemento | Definición |
|---|---|
| País | México |
| Periodo principal | 2020 |
| Cobertura territorial | Nacional y 32 entidades federativas |
| Fuente principal | Censo de Población y Vivienda 2020 (INEGI) |
| Objeto de estudio | Composición de la población por edad y sexo |
| Datos previstos | Tabulados oficiales por grupos quinquenales de edad y sexo |
| Unidad de registro de trabajo | Celda agregada: territorio × grupo de edad × sexo |
| Enfoque y alcance | Cuantitativo y descriptivo |
| Herramienta | R (RStudio como entorno de trabajo) |

Los valores de 2000 y 2010 se presentan únicamente como **antecedentes contextuales**; el análisis principal se delimita a 2020.

## 6. Fuentes de información

La fuente empírica principal será la tabla interactiva del INEGI **«Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020»**. Para los procedimientos de 2020 se descargarán los datos seleccionados y se conservará una copia original sin modificaciones.

Los documentos **Marco conceptual** y **Síntesis metodológica y conceptual** del Censo 2020 se emplearán para verificar definiciones, cobertura, fecha de referencia y criterios de clasificación (INEGI, 2021a, 2021b). Se registrarán la fecha de descarga y la tabla o archivo específico utilizado.

**Fuentes oficiales de consulta:**

- [Censo de Población y Vivienda 2020](https://www.inegi.org.mx/programas/ccpv/2020/)
- [Tabulados oficiales por entidad, edad y sexo](https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e)
- [Marco conceptual del Censo 2020](https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197520)
- [Síntesis metodológica y conceptual del Censo 2020](https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197537)

## 7. Variables e indicadores iniciales

| Variable o indicador | Tipo / unidad | Consideración metodológica |
|---|---|---|
| Población total | Conteo de personas | Comprobar su concordancia con el total censal publicado. |
| Sexo censal | Categoría | Utilizar las categorías originales; documentar valores no especificados si existen. |
| Grupo quinquenal de edad | Categoría ordinal | Conservar la agrupación oficial y el tratamiento de edades no especificadas. |
| Entidad federativa | Categoría nominal | Emplear claves y denominaciones oficiales. |
| Participación por sexo | Porcentaje | Explicitar si el denominador incluye todas las categorías publicadas. |
| Participación por grupo de edad | Porcentaje | Definir cómo se trata la edad no especificada. |
| Relación hombres-mujeres | Hombres por cada 100 mujeres | Indicar con claridad el numerador y el denominador. |
| Razón de dependencia demográfica | Personas de 0–14 y 65+ por cada 100 de 15–64 | Indicador convencional por edades; no mide dependencia económica efectiva. |

**Precisión sobre datos agrupados:** los totales, porcentajes y razones calculados con conteos censales pueden obtenerse directamente de los tabulados. En cambio, **la media, la varianza, la desviación estándar y los cuantiles exactos de la edad individual no pueden recuperarse, en general, solamente a partir de grupos quinquenales**. Cuando corresponda, se consultarán medidas oficiales publicadas o se presentarán estimaciones por intervalos claramente identificadas como aproximaciones. La categoría abierta «85 años y más» y las edades no especificadas requieren atención especial.

## 8. Estrategia metodológica

El análisis seguirá una secuencia única para facilitar su verificación:

1. **Adquisición:** seleccionar y descargar la información oficial de 2020.
2. **Preservación:** mantener intacta la copia descargada.
3. **Inspección:** identificar nombres de columnas, tipos de variables, categorías, unidades y metadatos.
4. **Validación:** verificar duplicados, valores faltantes, categorías no especificadas y coherencia de agregados.
5. **Transformación:** construir una tabla analítica documentada, sin modificar la fuente original.
6. **Cálculo:** obtener frecuencias, proporciones y razones demográficas con denominadores explícitos.
7. **Visualización:** crear gráficos con títulos, ejes, unidades y fuente.
8. **Comparación territorial:** aplicar definiciones uniformes a las 32 entidades federativas.
9. **Interpretación:** comentar resultados descriptivos, limitaciones y posibles implicaciones para las ciencias sociales.
10. **Reproducibilidad:** guardar los scripts, registrar las versiones de R y de los paquetes, y documentar cómo replicar el análisis.

Las fórmulas se fundamentarán en documentación demográfica oficial y en bibliografía estadística. Como apoyo introductorio para los fundamentos de estadística se utilizará Illowsky y Dean (2023), complementado por las fuentes metodológicas del INEGI.

## 9. Módulos del proyecto

| Módulo | Contenido | Producto previsto |
|---|---|---|
| 01 | Importación, exploración y validación de datos | Registro de la fuente, diccionario y controles de consistencia |
| 02 | Distribuciones de frecuencias | Tablas por edad y sexo |
| 03 | Medidas de tendencia central | Medidas oficiales o estimaciones justificadas, según los datos disponibles |
| 04 | Medidas de dispersión | Análisis de dispersión para variables donde sea válido |
| 05 | Medidas de posición | Cuantiles oficiales o aproximaciones debidamente identificadas |
| 06 | Indicadores demográficos | Razones, proporciones y grupos de edad |
| 07 | Visualización estadística | Pirámide poblacional y gráficos descriptivos |
| 08 | Comparación entre entidades federativas | Tablas y gráficos territoriales |

Los módulos 03–05 se ajustarán a la disponibilidad efectiva de datos: **no se inventarán edades individuales ni se presentarán aproximaciones como medidas exactas**.

## 10. Herramientas

- **R:** procesamiento, análisis estadístico y generación de resultados.
- **RStudio:** entorno de desarrollo opcional para organizar el trabajo.
- **`readr` y `readxl`:** importación de archivos de texto y Excel, según el formato descargado.
- **`dplyr` y `tidyr`:** preparación de datos y construcción de tablas.
- **`ggplot2`:** visualización estadística.
- **Quarto:** elaboración posterior del informe reproducible, si se instala y configura.

Solo se incorporarán dependencias cuando sean necesarias; se registrarán sus versiones y se documentará su instalación.

## 11. Estructura prevista del repositorio

```text
estructura-demografica-mexico/
├── README.md
├── LICENSE
├── .gitignore
├── datos/
│   ├── originales/
│   └── procesados/
├── codigo/
│   ├── 01_importacion_validacion.R
│   ├── 02_frecuencias.R
│   ├── 03_tendencia_central.R
│   ├── 04_dispersion.R
│   ├── 05_posicion.R
│   ├── 06_indicadores_demograficos.R
│   ├── 07_visualizaciones.R
│   └── 08_comparacion_territorial.R
├── resultados/
│   ├── tablas/
│   └── graficos/
├── documentacion/
│   ├── protocolo_metodologico.md
│   ├── diccionario_variables.md
│   ├── fuentes_estadisticas.md
│   └── reproducibilidad.md
└── informe/
    └── estructura_demografica.qmd
```

Esta es la **estructura prevista**; los archivos y carpetas se crearán gradualmente durante el desarrollo.

## 12. Criterios de calidad y reproducibilidad

- Emplear fuentes oficiales y bibliografía académica verificable.
- Registrar el origen, la fecha de descarga y la versión de cada archivo.
- No alterar ni sobrescribir los datos originales.
- Distinguir celdas agregadas de observaciones individuales.
- Comprobar los totales y subtotales frente a las cifras del INEGI.
- Explicitar fórmulas, denominadores y criterios para los valores no especificados.
- Presentar, cuando proceda, **cuatro decimales** en resultados estadísticos, sin redondear cálculos intermedios.
- Documentar el código con comentarios en español.
- Diferenciar hechos estadísticos, interpretación sustantiva y posibles hipótesis.
- No inferir causalidad a partir de diferencias descriptivas.
- Citar fuentes y documentos en **APA 7**, incluyendo páginas verificadas cuando se utilicen referencias puntuales o citas textuales.

## 13. Productos esperados

Se prevé generar una base procesada documentada, tablas de frecuencias, indicadores demográficos, una pirámide poblacional de México, comparaciones entre entidades federativas, scripts de R y un informe reproducible.

**No se presentan resultados empíricos nuevos en esta versión del repositorio.** Las cifras incluidas en el contexto provienen de publicaciones oficiales del INEGI; los resultados propios se incorporarán únicamente después de ejecutar y validar el código.

## 14. Referencias bibliográficas (APA 7)

Benítez Zenteno, R. (2002). Familia, derecho y política de población en México. *Papeles de Población, 8*(32), 31–57. https://www.scielo.org.mx/scielo.php?pid=S1405-74252002000200003&script=sci_arttext

Illowsky, B., y Dean, S. (2023). *Introductory statistics* (2.ª ed.). OpenStax. https://openstax.org/books/introductory-statistics-2e/pages/1-introduction

Instituto Nacional de Estadística y Geografía. (2021a). *Censo de Población y Vivienda 2020. Marco conceptual*. https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197520

Instituto Nacional de Estadística y Geografía. (2021b). *Censo de Población y Vivienda 2020. Síntesis metodológica y conceptual*. https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197537

Instituto Nacional de Estadística y Geografía. (2021c, 25 de enero). *En México somos 126 014 024 habitantes: Censo de Población y Vivienda 2020* (Comunicado de prensa núm. 24/21). https://www.inegi.org.mx/Contenidos/Saladeprensa/Boletines/2021/Estsociodemo/Resultcenso2020_Nal.Pdf

Instituto Nacional de Estadística y Geografía. (2023). *Mujeres y hombres en México 2021-2022*. https://www.inegi.org.mx/contenidos/productos/prod_serv/contenidos/espanol/bvinegi/productos/nueva_estruc/889463907381.pdf

Instituto Nacional de Estadística y Geografía. (s. f.). *Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020* [Tabla interactiva]. https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e

Partida Bush, V. (2005). La transición demográfica y el proceso de envejecimiento en México. *Papeles de Población, 11*(45), 9–27. https://rppoblacion.uaemex.mx/article/view/8701

Sobrino, J. (2024). Dinámica demográfica, forma urbana y densidad de población en ciudades de México, 1990-2020: ¿urbanización compacta o dispersa? *Estudios Demográficos y Urbanos, 39*(2), e2190. https://doi.org/10.24201/edu.v39i2.2190

Welti-Chanes, C. (2011). La demografía en México, las etapas iniciales de su evolución y sus aportaciones al desarrollo nacional. *Papeles de Población, 17*(69), 9–47. https://www.scielo.org.mx/scielo.php?pid=S1405-74252011000300002&script=sci_arttext

## 15. Estado del proyecto

**Etapa actual:** definición académica y metodológica del repositorio.

**Siguiente etapa:** crear las carpetas de trabajo y comenzar el **Módulo 01: importación, exploración y validación de datos**.

---

**Nota sobre licencias:** la licencia MIT del repositorio regula el código original que se publique aquí. Los datos del INEGI y los contenidos de las publicaciones citadas conservan sus propias condiciones de uso y atribución.
