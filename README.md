# Estructura demográfica de México

**Análisis estadístico descriptivo de la población por edad y sexo con R**

**Nivel:** básico · **Área:** ciencias sociales · **Cobertura:** México y sus 32 entidades federativas · **Año de estudio:** 2020 · **Estado:** en desarrollo

## 1. Presentación del proyecto

Este repositorio desarrolla un análisis estadístico descriptivo de la estructura demográfica de México mediante **R**, utilizando información oficial del **Censo de Población y Vivienda 2020** del Instituto Nacional de Estadística y Geografía (INEGI).

El proyecto busca comprender la composición de la población por edad y sexo, organizar datos censales, construir indicadores y elaborar visualizaciones reproducibles.

Está dirigido al aprendizaje de estadística aplicada a la **Economía, la Ciencia Política, las Políticas Públicas y la Economía Política**.

Aunque las técnicas computacionales son inicialmente básicas, se mantiene rigor en las definiciones estadísticas, los procedimientos de procesamiento, la validación de resultados y sus límites de interpretación.

## 2. Contexto demográfico de México

### 2.1. La demografía y el estudio de la población mexicana

La demografía estudia el tamaño, la estructura, la distribución y las transformaciones de las poblaciones humanas.

En México, su desarrollo como campo científico ha estado ligado a la producción de información estadística y a la formulación de políticas de población. Welti-Chanes (2011) reconstruye esa trayectoria y explica la importancia del conocimiento demográfico para comprender las relaciones entre crecimiento poblacional y condiciones sociales.

Desde esta perspectiva, estudiar la composición por edad y sexo permite identificar diferencias relevantes para el análisis económico, político, social y territorial.

### 2.2. Transición demográfica y estructura por edades

La población mexicana experimentó transformaciones importantes durante el siglo XX, vinculadas con la evolución de la mortalidad, la fecundidad y la migración.

Partida Bush (2005) señala que las distintas etapas de la transición demográfica dejan huellas en la estructura por edades y contribuyen a explicar el proceso de envejecimiento poblacional.

Tuirán (2002, p. 25) vincula la transición demográfica con las transformaciones de las trayectorias individuales y familiares y con cambios en la organización social.

Benítez Zenteno (2002) examina las relaciones entre la organización familiar y la política de población en México.

### 2.3. Características de la población en 2020

Según el Censo de Población y Vivienda 2020, México registró una población de 126,014,024 habitantes.

| Indicador | Resultado |
|---|---:|
| Población total | 126,014,024 |
| Hombres | 61,473,390 |
| Mujeres | 64,540,634 |
| Edad mediana oficial | 29 años |
| Entidades federativas | 32 |

La edad mediana pasó de 22 años en 2000 a 26 años en 2010 y 29 años en 2020 (INEGI, 2021c, pp. 1–2).

El INEGI (2023) documenta transformaciones en la composición de la población por edad y sexo que permiten contextualizar el análisis de la estructura demográfica mexicana.

### 2.4. Diferencias territoriales

Sobrino (2024) examina patrones diferenciados de dinámica demográfica y expansión territorial en las ciudades mexicanas entre 1990 y 2020.

El presente proyecto se concentra en la comparación descriptiva entre entidades federativas, utilizando criterios estadísticos homogéneos.

### 2.5. Relevancia para las ciencias sociales

- **Economía:** estructura poblacional, oferta potencial de trabajo, consumo y protección social.
- **Ciencia Política:** representación política, participación y distribución territorial de la población.
- **Políticas Públicas:** planificación de servicios educativos, sanitarios, sociales y de cuidados.
- **Economía Política:** cambio demográfico, distribución de recursos y organización económica y social.

Estas relaciones constituyen posibilidades de interpretación, no efectos causales identificados por el proyecto.

## 3. Planteamiento del problema

La estructura demográfica nacional puede resumirse mediante cifras agregadas, pero estas no muestran por sí solas cómo se distribuye la población entre grupos de edad y sexo ni cómo varía dicha composición entre entidades federativas.

Para describir estas diferencias se requieren datos comparables, definiciones consistentes y procedimientos estadísticos verificables.

**Pregunta principal:**

¿Cómo se distribuye la población mexicana por edad y sexo y qué diferencias presenta su estructura demográfica entre las entidades federativas, según el Censo de Población y Vivienda 2020?

## 4. Objetivos

### 4.1. Objetivo general

Analizar la estructura demográfica de México por edad y sexo mediante técnicas de estadística descriptiva implementadas en R, utilizando información censal oficial correspondiente a 2020.

### 4.2. Objetivos específicos

1. Importar, explorar y validar los tabulados demográficos del INEGI.
2. Construir distribuciones de frecuencias univariadas y bivariadas.
3. Calcular medidas estadísticas descriptivas.
4. Construir indicadores demográficos básicos.
5. Elaborar tablas, gráficos y pirámides poblacionales.
6. Comparar la estructura demográfica de las 32 entidades federativas.
7. Garantizar la reproducibilidad de los procedimientos estadísticos.
8. Interpretar los resultados desde las ciencias sociales.

## 5. Delimitación

| Elemento | Definición |
|---|---|
| País | México |
| Año de referencia | 2020 |
| Cobertura | Nacional y estatal |
| Fuente | Censo de Población y Vivienda 2020 |
| Objeto de estudio | Estructura demográfica por edad y sexo |
| Enfoque | Cuantitativo |
| Alcance | Descriptivo |
| Diseño | Transversal |
| Unidad de registro | Territorio y grupo de edad |
| Herramienta computacional | R |
| Entorno de desarrollo | RStudio |

Los datos corresponden a registros censales agregados, no a microdatos individuales.

## 6. Fuentes de información

La fuente principal corresponde al tabulado oficial:

**Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020.**

Se utilizan exclusivamente los datos correspondientes a 2020.

### Fuentes oficiales

- [Censo de Población y Vivienda 2020](https://www.inegi.org.mx/programas/ccpv/2020/)
- [Tabulados oficiales](https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e)
- [Marco conceptual](https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197520)
- [Síntesis metodológica y conceptual](https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197537)

La documentación de las fuentes puede consultarse en:

[Fuentes estadísticas](documentacion/fuentes_estadisticas.md).

## 7. Variables e indicadores

| Variable | Tipo o unidad |
|---|---|
| Entidad federativa | Cualitativa nominal |
| Grupo de edad especificada | Cualitativa ordinal |
| Sexo censal | Cualitativa nominal |
| Población total | Conteo de personas |
| Población masculina | Conteo de personas |
| Población femenina | Conteo de personas |

### Indicadores estadísticos

- Frecuencia absoluta.
- Frecuencia relativa.
- Frecuencia porcentual.
- Frecuencia acumulada.
- Frecuencia conjunta.
- Frecuencia marginal.
- Frecuencia condicional.
- Medidas de tendencia central.
- Medidas de dispersión.
- Medidas de posición.

### Indicadores demográficos previstos

- Relación hombres-mujeres.
- Razón de dependencia demográfica.
- Índice de envejecimiento.
- Distribución por grandes grupos de edad.
- Participación territorial de la población.

Los indicadores de dependencia demográfica no equivalen necesariamente a medidas de dependencia económica efectiva.

## 8. Estrategia metodológica

El análisis sigue una secuencia reproducible:

1. Adquisición de información oficial.
2. Preservación de los datos originales.
3. Inspección de la estructura de los datos.
4. Validación de registros y totales.
5. Preparación de la base analítica.
6. Construcción de distribuciones de frecuencias.
7. Cálculo de medidas estadísticas.
8. Construcción de indicadores demográficos.
9. Visualización estadística.
10. Comparación territorial e interpretación.

El fundamento estadístico se apoya en Illowsky y Dean (2023), complementado con documentación metodológica y conceptual del INEGI.

**Tratamiento de los datos agrupados:** los conteos y proporciones pueden calcularse directamente. Las medidas exactas de edad individual, como la media, la varianza y los cuantiles, no pueden recuperarse generalmente a partir de intervalos agrupados.

El intervalo abierto «100 años y más» requiere un tratamiento metodológico específico.

## 9. Módulos del proyecto

| Módulo | Contenido | Estado |
|---|---|---|
| 01 | Importación, exploración y validación | Completado |
| 02 | Distribuciones de frecuencias | Completado |
| 03 | Medidas de tendencia central | Pendiente |
| 04 | Medidas de dispersión | Pendiente |
| 05 | Medidas de posición | Pendiente |
| 06 | Indicadores demográficos | Pendiente |
| 07 | Visualización estadística | Pendiente |
| 08 | Comparación entre entidades federativas | Pendiente |

### 9.1. Módulo 01. Importación y validación

Se importaron, organizaron y validaron los datos censales originales.

| Indicador de control | Resultado |
|---|---:|
| Registros | 759 |
| Variables | 5 |
| Entidades federativas | 32 |
| Agregado nacional | 1 |
| Categorías por territorio | 23 |
| Validación general | Aprobada |

**Archivos:**

- [Script de R](codigo/01_importacion_validacion.R)
- [Informe de validación](documentacion/resultados_validacion_modulo_01.md)
- [Base validada CSV](datos/procesados/poblacion_mexico_2020_validada.csv)
- [Base validada RDS](datos/procesados/poblacion_mexico_2020_validada.rds)

### 9.2. Módulo 02. Distribuciones de frecuencias

Se construyeron distribuciones univariadas, tablas de contingencia y distribuciones marginales y condicionales.

Los resultados comprenden:

- Distribución nacional por sexo.
- Distribución nacional por edad.
- Distribuciones conjuntas por edad y sexo.
- Distribuciones condicionales por edad y sexo.
- Distribución por entidad federativa.
- Distribuciones por entidad federativa y sexo.
- Distribuciones por entidad federativa y edad.
- Aplicación territorial para Puebla.

| Indicador de control | Resultado |
|---|---:|
| Validaciones estadísticas | 56 |
| Validaciones aprobadas | 56 |
| Archivos CSV | 21 |
| Archivos RDS | 1 |
| Integridad de archivos | Verificada |

**Archivos:**

- [Script de R](codigo/02_distribuciones_frecuencias.R)
- [Informe académico](documentacion/resultados_modulo_02.md)
- [Tablas estadísticas](resultados/tablas/modulo_02/)
- [Informe de validación](resultados/tablas/modulo_02/21_informe_validacion.csv)
- [Resultados consolidados RDS](resultados/tablas/modulo_02/resultados_modulo_02.rds)

## 10. Principales resultados

### 10.1. Distribución nacional por sexo

| Sexo | Población | Participación (%) |
|---|---:|---:|
| Hombres | 61,473,390 | 48.7830 |
| Mujeres | 64,540,634 | 51.2170 |
| Total | 126,014,024 | 100.0000 |

### 10.2. Cobertura de la información por edad

| Categoría | Población | Participación (%) |
|---|---:|---:|
| Edad especificada | 125,740,638 | 99.7831 |
| Edad no especificada | 273,386 | 0.2169 |
| Total | 126,014,024 | 100.0000 |

### 10.3. Estructura por edades

Entre la población con edad especificada:

| Grupo | Participación (%) |
|---|---:|
| Menores de 15 años | 25.2546 |
| Menores de 30 años | 50.0849 |
| Personas de 65 años y más | 8.2089 |

El grupo de 10 a 14 años presenta la mayor frecuencia absoluta, con 10,943,540 habitantes.

### 10.4. Distribución territorial

| Posición | Entidad federativa | Población | Participación (%) |
|---:|---|---:|---:|
| 1 | Estado de México | 16,992,418 | 13.4845 |
| 2 | Ciudad de México | 9,209,944 | 7.3087 |
| 3 | Jalisco | 8,348,151 | 6.6248 |
| 4 | Veracruz | 8,062,579 | 6.3982 |
| 5 | Puebla | 6,583,278 | 5.2242 |

Las cinco entidades más pobladas concentran el 39.0404 % de la población nacional.

### 10.5. Composición por edad y sexo

| Grupo de edad | Hombres (%) | Mujeres (%) |
|---|---:|---:|
| 0 a 4 años | 50.5355 | 49.4645 |
| 20 a 24 años | 49.5667 | 50.4333 |
| 65 a 69 años | 46.8262 | 53.1738 |
| 80 a 84 años | 44.5659 | 55.4341 |
| 100 años y más | 36.3159 | 63.6841 |

Se observa una mayor participación femenina a partir del grupo de 20 a 24 años, especialmente en las edades avanzadas.

### 10.6. Aplicación territorial: Puebla

| Grupo de edad | Población | Participación estatal (%) |
|---|---:|---:|
| 0 a 4 años | 578,779 | 8.7917 |
| 5 a 9 años | 598,550 | 9.0920 |
| 10 a 14 años | 603,375 | 9.1653 |
| 15 a 19 años | 607,200 | 9.2234 |
| 20 a 24 años | 570,646 | 8.6681 |

La población menor de 15 años representa el 27.0489 % de la población total de Puebla, frente al 25.1998 % de la población nacional total.

Fuente: elaboración propia con información del Censo de Población y Vivienda 2020 (INEGI, s. f.).

## 11. Herramientas computacionales

- **R:** procesamiento y análisis estadístico.
- **RStudio:** organización del proyecto.
- **readxl:** importación de archivos Excel.
- **Git:** control de versiones.
- **GitHub:** documentación y publicación del proyecto.
- **ggplot2:** visualización estadística prevista.
- **Quarto:** elaboración posterior de informes reproducibles.

## 12. Estructura del repositorio

```text
estructura-demografica-mexico/
├── README.md
├── LICENSE
├── .gitignore
├── estructura-demografica-mexico.Rproj
├── datos/
│   ├── originales/
│   └── procesados/
│       ├── poblacion_mexico_2020_validada.csv
│       └── poblacion_mexico_2020_validada.rds
├── codigo/
│   ├── 01_importacion_validacion.R
│   └── 02_distribuciones_frecuencias.R
├── documentacion/
│   ├── protocolo_metodologico.md
│   ├── diccionario_variables.md
│   ├── fuentes_estadisticas.md
│   ├── resultados_validacion_modulo_01.md
│   └── resultados_modulo_02.md
└── resultados/
    └── tablas/
        └── modulo_02/
            ├── 21 archivos CSV
            └── resultados_modulo_02.rds
```

Los scripts y productos de los módulos siguientes se incorporarán gradualmente.

## 13. Reproducibilidad

Para reproducir el análisis, abrir el proyecto en RStudio y ejecutar los scripts desde el directorio principal.

```r
# Módulo 01
source("codigo/01_importacion_validacion.R")

# Módulo 02
source("codigo/02_distribuciones_frecuencias.R")
```

El módulo 02 también puede ejecutarse directamente utilizando la base RDS validada incluida en el repositorio.

Los resultados se generan en:

`resultados/tablas/modulo_02/`

### Criterios de calidad

- Utilizar información oficial y bibliografía verificable.
- Preservar los archivos originales.
- Comprobar la consistencia de los resultados.
- Registrar las decisiones metodológicas.
- Conservar la precisión numérica de los cálculos.
- Presentar los resultados estadísticos con cuatro decimales cuando corresponda.
- Documentar el código en español.
- Utilizar referencias bibliográficas en APA 7.
- No establecer relaciones causales mediante análisis descriptivos.

## 14. Limitaciones metodológicas

- El estudio corresponde exclusivamente al año 2020.
- Se utilizan datos censales agregados.
- No se dispone de edades individuales.
- Las distribuciones acumuladas excluyen la edad no especificada.
- Las tablas conjuntas conservan la categoría de edad no especificada.
- No se realizan inferencias causales.
- No se infieren tendencias demográficas a partir de un único año censal.
- Las diferencias poblacionales territoriales no constituyen medidas de densidad demográfica.

## 15. Referencias bibliográficas (APA 7)

Benítez Zenteno, R. (2002). Familia, derecho y política de población en México. *Papeles de Población, 8*(32), 31–57. https://www.scielo.org.mx/scielo.php?pid=S1405-74252002000200003&script=sci_arttext

Illowsky, B., y Dean, S. (2023). *Introductory statistics* (2.ª ed.). OpenStax. https://openstax.org/books/introductory-statistics-2e/pages/1-introduction

Instituto Nacional de Estadística y Geografía. (2021a). *Censo de Población y Vivienda 2020. Marco conceptual*. https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197520

Instituto Nacional de Estadística y Geografía. (2021b). *Censo de Población y Vivienda 2020. Síntesis metodológica y conceptual*. https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197537

Instituto Nacional de Estadística y Geografía. (2021c, 25 de enero). *En México somos 126 014 024 habitantes: Censo de Población y Vivienda 2020* (Comunicado de prensa núm. 24/21). https://www.inegi.org.mx/Contenidos/Saladeprensa/Boletines/2021/Estsociodemo/Resultcenso2020_Nal.Pdf

Instituto Nacional de Estadística y Geografía. (2023). *Mujeres y hombres en México 2021-2022*. https://www.inegi.org.mx/contenidos/productos/prod_serv/contenidos/espanol/bvinegi/productos/nueva_estruc/889463907381.pdf

Instituto Nacional de Estadística y Geografía. (s. f.). *Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020* [Tabla interactiva]. https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e

Partida Bush, V. (2005). La transición demográfica y el proceso de envejecimiento en México. *Papeles de Población, 11*(45), 9–27. https://rppoblacion.uaemex.mx/article/view/8701

Sobrino, J. (2024). Dinámica demográfica, forma urbana y densidad de población en ciudades de México, 1990-2020: ¿urbanización compacta o dispersa? *Estudios Demográficos y Urbanos, 39*(2), 1–31. https://doi.org/10.24201/edu.v39i2.2190

Tuirán, R. (2002). Transición demográfica, trayectorias de vida y desigualdad social en México: lecciones y opciones. *Papeles de Población, 8*(31), 25–66. https://www.redalyc.org/pdf/112/11203102.pdf

Welti-Chanes, C. (2011). La demografía en México, las etapas iniciales de su evolución y sus aportaciones al desarrollo nacional. *Papeles de Población, 17*(69), 9–47. https://www.scielo.org.mx/scielo.php?pid=S1405-74252011000300002&script=sci_arttext

## 16. Estado del proyecto

- [x] Definición académica y metodológica.
- [x] Módulo 01. Importación y validación.
- [x] Módulo 02. Distribuciones de frecuencias.
- [ ] Módulo 03. Medidas de tendencia central.
- [ ] Módulo 04. Medidas de dispersión.
- [ ] Módulo 05. Medidas de posición.
- [ ] Módulo 06. Indicadores demográficos.
- [ ] Módulo 07. Visualización estadística.
- [ ] Módulo 08. Comparación territorial.
- [ ] Informe final reproducible.

## 17. Autor

**Aldo Rodríguez Lechuga**

Licenciado en Economía.

Áreas de interés: Economía Política, Ciencia Política, Crecimiento y Desarrollo Económico, Políticas Públicas y Métodos Cuantitativos para las Ciencias Sociales.

## 18. Licencia

El código original del proyecto se distribuye bajo la licencia MIT.

Los datos del INEGI y los contenidos de las publicaciones citadas conservan sus respectivas condiciones de uso y atribución.