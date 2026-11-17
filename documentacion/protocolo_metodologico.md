# Protocolo metodológico

**Proyecto:** Estructura demográfica de México: análisis estadístico descriptivo de la población por edad y sexo con R  
**Repositorio:** `estructura-demografica-mexico`  
**Documento:** `documentacion/protocolo_metodologico.md`  
**Versión:** 1.0 — 17 de noviembre de 2026  
**Estado:** Protocolo previo a la ejecución de los scripts de R

## 1. Propósito

Este protocolo fija de antemano los criterios conceptuales, estadísticos y computacionales del proyecto. Su función es determinar **qué se analizará, con qué información, mediante qué procedimientos, bajo cuáles reglas de validación y con qué límites interpretativos**, antes de producir resultados. Con ello se busca evitar cambios arbitrarios de denominadores, dobles conteos y conclusiones que excedan la información disponible.

El estudio es **cuantitativo, transversal y descriptivo**; utiliza tabulados públicos del Censo de Población y Vivienda 2020 del Instituto Nacional de Estadística y Geografía (INEGI). No propone un diseño causal ni pruebas inferenciales. El uso de un censo como fuente original **no convierte al archivo descargado en microdatos individuales**: la base seleccionada es una tabla agregada (INEGI, 2021a, 2021b).

## 2. Problema, pregunta y objetivos

### 2.1. Problema descriptivo

Conocer la cifra total de habitantes no permite caracterizar cómo se distribuye la población mexicana por edad y sexo ni comparar la composición de las entidades federativas. Para efectuar esas comparaciones se necesitan clasificaciones homogéneas, recuentos validados, denominadores explícitos y reglas uniformes de procesamiento.

### 2.2. Pregunta principal

**¿Cómo se distribuye la población de México por edad y sexo, y qué diferencias descriptivas presenta su estructura demográfica entre las entidades federativas, de acuerdo con los tabulados del Censo de Población y Vivienda 2020?**

### 2.3. Objetivo general

Describir y comparar la estructura demográfica de México en 2020 mediante frecuencias, proporciones, razones e instrumentos gráficos, utilizando código reproducible en R y datos censales oficiales.

### 2.4. Objetivos operativos

1. Preservar e identificar el archivo original, su fecha de consulta y sus metadatos.
2. Importar, inspeccionar y validar las 759 celdas territoriales-etarias del tabulado seleccionado.
3. Construir distribuciones de frecuencia por edad y sexo, distinguiendo totales de desgloses.
4. Elaborar indicadores demográficos básicos con fórmulas y denominadores documentados.
5. Comparar las 32 entidades federativas bajo definiciones homogéneas.
6. Generar tablas, gráficos e informe con código reproducible.
7. Distinguir resultados observados, limitaciones de medición e interpretaciones desde las ciencias sociales.

## 3. Alcance y unidades de análisis

| Elemento | Decisión metodológica |
|---|---|
| Cobertura temporal | Censo 2020; la información está referida al **15 de marzo de 2020**. |
| Cobertura espacial | México: agregado nacional y 32 entidades federativas. |
| Fuente empírica | Tabulado interactivo del INEGI sobre población por entidad, grupo quinquenal de edad y sexo. |
| Archivo conservado | `datos/originales/Poblacion_01.xlsx`. |
| Hoja y rango analítico | `Tabulado`, rango `A8:E766` (759 filas). |
| Unidad de registro del archivo | **Entidad o agregado nacional × categoría de edad**. |
| Medidas originales | Tres recuentos agregados: `poblacion_total`, `hombres`, `mujeres`. |
| Unidad de medida | Personas (conteos enteros). |
| Unidad de comparación | Entidad federativa, después de producir indicadores territoriales. |
| Naturaleza del estudio | Descriptivo, sin inferencia causal. |

El INEGI (2021b, p. 6) documenta que el Censo 2020 se realizó como un censo **de derecho** —población en su residencia habitual— y fija las cero horas del 15 de marzo como fecha de referencia estadística. Esa fecha no debe confundirse con la descarga del archivo, consignada el **17 de noviembre de 2026**.

## 4. Datos y estructura original

El archivo descargado presenta **33 denominaciones geográficas × 23 categorías de edad = 759 registros**. Las categorías de edad comprenden:

- **21 intervalos:** de `0 a 4 años` a `95 a 99 años`, más `100 años y más` (intervalo abierto).
- **`No especificado`:** categoría de edad que no corresponde a un intervalo ordenado.
- **`Total`:** suma territorial por edad; no es una categoría de edad individual.

Las columnas originales de la hoja se corresponden con:

| Columna Excel | Nombre en R | Significado | Tipo |
|---|---|---|---|
| A | `entidad` | Agregado nacional o entidad federativa | Nominal |
| B | `grupo_edad` | Intervalo o categoría especial de edad | Ordinal parcial |
| C | `poblacion_total` | Personas de ambos sexos | Conteo entero |
| D | `hombres` | Hombres | Conteo entero |
| E | `mujeres` | Mujeres | Conteo entero |

Las filas 1 a 7 contienen metadatos y encabezados; las filas posteriores a la 766 contienen notas y fuentes, que **no** se importarán como observaciones. La tabla original contiene tres columnas de recuentos y **no** una variable individual `sexo`. Toda transformación a formato largo se etiquetará como derivada. La estructura se desarrolla en [`diccionario_variables.md`](diccionario_variables.md).

### 4.1. Preservación de la fuente

- El archivo original no será editado, renombrado ni sobrescrito por los scripts.
- Las bases de trabajo se guardarán en `datos/procesados/`.
- Se registrarán archivo, hoja, rango, fecha de consulta y origen del tabulado; se añadirá una huella digital SHA-256 durante la implementación.
- Se documentará cualquier sustitución futura del archivo si el INEGI actualiza su descarga.

### 4.2. Estimación de población en viviendas sin información

El propio tabulado advierte que para 2020 incluye una estimación de **6 337 751 personas correspondientes a 1 588 422 viviendas sin información de ocupantes**. Esta nota se conservará como limitación de la fuente. **No se igualará ni restará** esa cifra de la categoría `No especificado` de edad, que cumple otra función dentro del tabulado (INEGI, s. f.).

## 5. Reglas de validación previas al análisis

El primer script de R implementará pruebas automáticas. Ninguna base derivada se considerará validada hasta que pasen los controles obligatorios.

| ID | Control | Regla de aceptación | Consecuencia si falla |
|---|---|---|---|
| V01 | Estructura | Existe la hoja `Tabulado` y el rango esperado. | Detener procesamiento. |
| V02 | Dimensiones | 759 filas; 33 territorios; 23 categorías por territorio. | Detener y revisar descarga. |
| V03 | Clave | Sin duplicados en `entidad + grupo_edad`. | Detener y localizar duplicados. |
| V04 | Integridad numérica | Conteos presentes, enteros y no negativos. | Detener; no imputar. |
| V05 | Identidad por registro | `poblacion_total = hombres + mujeres` en las 759 filas. | Detener y reportar casos. |
| V06 | Total territorial | Suma de los 21 intervalos + `No especificado` = fila `Total`, por cada territorio y sexo. | Detener y reportar diferencias. |
| V07 | Total geográfico | Suma de 32 entidades = `Estados Unidos Mexicanos`, para cada categoría de edad y columna de población. | Detener y reportar diferencias. |
| V08 | Categorías | Solo etiquetas de edad previstas en el diccionario. | Revisar etiquetas antes de continuar. |
| V09 | Referencia censal | En la fila nacional `Total`: 126 014 024 personas, 61 473 390 hombres, 64 540 634 mujeres. | Detener y verificar selección. |
| V10 | Edad no especificada | En la fila nacional respectiva: 273 386 personas, 136 194 hombres, 137 192 mujeres. | Revisar selección y metadatos. |

Los valores de V09 y V10 son **cifras de control tomadas de la descarga original**, no resultados analíticos producidos por el código. Las pruebas comprobarán la congruencia aritmética del archivo; **no equivalen a una auditoría de la cobertura o de todos los procedimientos del operativo censal**.

## 6. Definiciones, cálculos y denominadores

Sea \(N_{esg}\) el número de personas del territorio \(e\), grupo de edad \(g\) y categoría de sexo \(s\). No se utilizará `Total` simultáneamente con sus categorías desglosadas para realizar una suma.

### 6.1. Frecuencias absolutas

Para cada territorio se reportará el conteo de personas según grupo de edad y sexo. Los recuentos de hombres y mujeres pueden sumarse para recuperar el total de la misma celda; las filas `Total` **no** se volverán a sumar con los grupos de edad.

### 6.2. Frecuencias relativas y porcentajes

Para una categoría con recuento \(n_g\) y población de referencia \(N\):

\[
 f_g=\frac{n_g}{N},\qquad p_g=100\,\frac{n_g}{N}.
\]

Se distinguirán explícitamente dos posibles denominadores:

- **Población total:** incluye personas de edad `No especificado`. Se usará al describir la participación de una edad dentro del total territorial.
- **Población con edad especificada:** excluye `No especificado`. Se usará al comparar la **distribución condicional de edades conocidas** y se indicará en cada tabla o gráfico.

Se evitarán porcentajes cuyo denominador no esté identificado. Las proporciones por sexo del total territorial usarán la fila `Total` para ese territorio.

### 6.3. Distribución por grandes grupos de edad

Se utilizarán inicialmente los cortes convencionales:

| Grupo | Intervalos incorporados | Precaución |
|---|---|---|
| 0–14 años | 0–4, 5–9, 10–14 | Edad especificada. |
| 15–64 años | 15–19 hasta 60–64 | No equivale a población económicamente activa. |
| 65 años y más | 65–69 hasta 100 años y más | Incluye intervalo abierto. |

Los tres grupos cubren únicamente la población **con edad especificada**; si se presentan como porcentajes de ella, su suma debe ser 100 % dentro de la tolerancia de presentación. El registro `No especificado` se mostrará por separado.

### 6.4. Relación hombres-mujeres

\[
\text{Relación hombres-mujeres}=100\frac{H}{M},
\]

con \(H\) hombres y \(M\) mujeres de la misma población de referencia. Interpretación: número de hombres por cada 100 mujeres. No se calculará si \(M=0\). Para comparar territorios se utilizará la fila `Total` de cada uno, salvo cuando se declare expresamente una razón por edad.

### 6.5. Razón de dependencia demográfica

\[
\text{Razón de dependencia}=100\frac{P_{0-14}+P_{65+}}{P_{15-64}}.
\]

El numerador y denominador se construirán solamente con edades **especificadas**, bajo los mismos cortes en todo el país. Se exigirá \(P_{15-64}>0\). Este índice expresa una **relación entre grupos etarios**, no una medición directa de dependencia económica, ocupación ni transferencias intrafamiliares.

Se podrán descomponer sus componentes para fines descriptivos:

\[
\text{Dependencia infantil}=100\frac{P_{0-14}}{P_{15-64}},\qquad
\text{Dependencia de adultos mayores}=100\frac{P_{65+}}{P_{15-64}}.
\]

### 6.6. Medidas no identificables exactamente

El archivo contiene **intervalos de edad**, no edades individuales. En consecuencia:

- **No se obtendrán como estadísticas exactas de edad individual** la media, varianza, desviación estándar, moda puntual ni los percentiles precisos.
- Si en un módulo posterior se utilizan **estimaciones de datos agrupados**, serán rotuladas como aproximadas, con supuestos, fórmulas y análisis de sensibilidad; **no** se asignará arbitrariamente un punto medio a `100 años y más`.
- Cuando una medida oficial individual (por ejemplo, la mediana publicada por el INEGI) se utilice como contexto, se distinguirá claramente de las medidas estimadas en este repositorio.
- Los módulos sobre tendencia central, dispersión y posición podrán utilizar, de manera válida, otras variables derivadas **territoriales** (por ejemplo, dispersión entre porcentajes estatales), aclarando que **la unidad estadística será la entidad**, no la edad de una persona.

Esta precaución sigue la distinción entre descripción de distribuciones y propiedades de las mediciones expuesta en los fundamentos de estadística de Illowsky y Dean (2023), sin atribuir a su obra decisiones particulares de este proyecto.

## 7. Tratamiento de datos especiales

**`Total` (edad):** se conservará como fila de control y para indicadores territoriales globales. No entrará en distribuciones que ya incorporen los intervalos de edad.

**`No especificado`:** se conservará en la fuente y se reportará como recuento y porcentaje territorial. No se redistribuirá entre edades ni se convertirá en cero. Cada resultado indicará si lo incluye en el denominador.

**`100 años y más`:** se conservará como grupo abierto para frecuencias, proporciones y razones. No se supondrá edad máxima ni punto medio.

**Nombres de entidades:** se respetará la denominación oficial del tabulado; cualquier normalización futura deberá ser explícita y reversible.

**Valores faltantes inesperados, errores o duplicados:** detendrán las transformaciones correspondientes. No habrá imputación automática ni modificación silenciosa de la fuente.

## 8. Plan analítico por módulos

| Módulo | Procedimiento previsto | Evidencia de terminación |
|---|---|---|
| **01. Importación y validación** | Lectura de XLSX, tipos, categorías, claves, consistencia aritmética, metadatos y archivo procesado. | Script ejecutable y registro de validaciones. |
| **02. Frecuencias** | Tablas por sexo y grupos quinquenales; porcentajes con denominadores identificados. | Tablas reproducibles y sumas verificadas. |
| **03. Tendencia central** | Discusión de identificabilidad de edad media/mediana/moda; uso de medidas oficiales o aproximadas solo si se justifican. | Informe que distinga estimación, fuente y alcance. |
| **04. Dispersión** | Dispersión válida de indicadores estatales y, solo si procede, aproximaciones etarias documentadas. | Fórmulas, unidad de análisis y controles. |
| **05. Posición** | Cuantiles publicados oficialmente o aproximaciones por grupos claramente señaladas. | Notas de precisión y supuestos. |
| **06. Indicadores demográficos** | Grupos 0–14/15–64/65+, relación hombres-mujeres y razones de dependencia. | Tabla nacional y cálculos territoriales verificables. |
| **07. Visualizaciones** | Pirámide poblacional y gráficos adecuados a datos agrupados. | Figuras con títulos, fuentes, unidades y escala. |
| **08. Comparación territorial** | Comparar las 32 entidades con las mismas definiciones. | Tablas y gráficos estatales, sin doble conteo nacional. |

Los módulos podrán ajustar su orden interno si una dependencia técnica lo exige, pero **cualquier cambio relevante se registrará**. No se aplicarán pruebas de hipótesis ni regresiones en esta etapa básica.

## 9. Convenciones de programación en R

1. Los scripts estarán en `codigo/`, numerados según la secuencia de trabajo y con comentarios en español.
2. La ruta del archivo se construirá **relativa a la raíz del proyecto**; se evitarán rutas absolutas personales.
3. Se utilizará `readxl` para importar el XLSX; se añadirán otros paquetes solo cuando resulten necesarios.
4. Todo script tendrá un encabezado con objetivo, entradas, salidas, dependencias y versión.
5. Los scripts realizarán comprobaciones programáticas con mensajes interpretables de aprobación o error.
6. No se editará manualmente una tabla o gráfica para simular un resultado del código.
7. Los resultados se guardarán en `resultados/tablas/` y `resultados/graficos/`.
8. La sesión de R y las versiones de paquetes se documentarán en la etapa de reproducibilidad (por ejemplo, `sessionInfo()`).
9. Los conteos se conservarán como enteros y **no se redondearán cálculos intermedios**; los indicadores se mostrarán con cuatro decimales cuando corresponda.
10. Se definirán criterios explícitos para que un error de lectura, tipo, total o duplicado **detenga** la ejecución antes de producir resultados.

## 10. Criterios de presentación y calidad

Cada tabla contendrá título, territorio o escala, año, variable, unidad de medida, denominador cuando sea pertinente, fuente y nota metodológica. Cada figura identificará ejes, categorías, unidades y fuente, con etiquetas legibles. Las tasas y porcentajes se expresarán consistentemente; los conteos de personas se presentarán sin decimales.

Se comprobará que:

- Las distribuciones de proporciones sumen 1 (o 100 %) salvo redondeo de presentación.
- La pirámide poblacional no incluya las filas `Total` ni `No especificado` como barras etarias.
- Los comparativos excluyan el agregado nacional de las sumas de las 32 entidades.
- Los indicadores estatales empleen exactamente los mismos cortes de edad.
- Los datos representados se puedan remontar a una celda y a una transformación documentada.

## 11. Interpretación para ciencias sociales

Las aplicaciones tendrán un carácter **contextual y descriptivo**:

- **Economía:** composición por edades y población en edades laborales convencionales; no se confundirá con empleo o participación económica observados.
- **Ciencia Política:** contexto sociodemográfico para el estudio de población y representación; no se deducirán preferencias ni comportamientos electorales.
- **Políticas Públicas:** distribución de grupos poblacionales relevantes para planeación de educación, salud y cuidados; no se inferirá automáticamente demanda efectiva de servicios.
- **Economía Política:** características demográficas que pueden contextualizar relaciones entre población, desarrollo y distribución de recursos; no se atribuirán mecanismos causales sin un diseño adicional.

Los resultados se presentarán con distinción entre **dato oficial, cálculo propio, interpretación descriptiva e hipótesis para investigación futura**.

## 12. Riesgos, límites y decisiones abiertas

| Riesgo o limitación | Regla preventiva |
|---|---|
| Datos agregados, no edades individuales | No usar medidas individuales como si fueran exactas. |
| Población de edad no especificada | Documentar recuento y denominador en cada cálculo. |
| Intervalo de 100 años y más abierto | No imputar punto medio de forma arbitraria. |
| Agregado nacional duplicable con estados | Separar nacional y estatal durante las sumas. |
| Cambios posteriores del tabulado interactivo | Conservar XLSX original y su huella digital. |
| Referencia temporal única (2020) | No atribuir tendencias entre años a un análisis transversal. |
| Naturaleza censal con estimaciones documentadas | No afirmar ausencia de error de medición o cobertura. |
| Interpretaciones políticas o económicas amplias | Mantenerlas como contexto, no como evidencia causal. |

**Decisiones pendientes de implementación:** nombres exactos de archivos procesados, dependencias finales de R, procedimiento de registro de errores y formato final del informe Quarto. Se definirán y justificarán al implementar el Módulo 01; no se consideran acciones ya ejecutadas.

## 13. Condiciones para aprobar el Módulo 01

El módulo inicial quedará **aprobado** únicamente cuando:

1. El script se ejecute desde la raíz del proyecto sin rutas personales.
2. Importe correctamente las 759 filas y las cinco columnas analíticas.
3. Produzca y guarde los resultados de las verificaciones V01–V10.
4. Termine con un mensaje inequívoco de éxito o se detenga ante un fallo.
5. Genere una base procesada trazable sin alterar el archivo original.
6. Documente versión de R, paquetes utilizados y decisiones de limpieza.
7. Sus resultados puedan reproducirse en otra sesión con la misma descarga.

**Estado actual:** los controles aquí descritos están **especificados**, pero **todavía no han sido implementados ni ejecutados mediante los scripts del repositorio**. Las verificaciones preliminares del Excel se documentan separadamente en [`fuentes_estadisticas.md`](fuentes_estadisticas.md).

## 14. Referencias (APA 7)

Illowsky, B., y Dean, S. (2023). *Introductory statistics* (2.ª ed.). OpenStax. https://openstax.org/books/introductory-statistics-2e/pages/1-introduction

Instituto Nacional de Estadística y Geografía. (2021a). *Censo de Población y Vivienda 2020. Marco conceptual*. https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197520

Instituto Nacional de Estadística y Geografía. (2021b). *Censo de Población y Vivienda 2020. Síntesis metodológica y conceptual*. https://www.inegi.org.mx/app/biblioteca/ficha.html?upc=702825197537

Instituto Nacional de Estadística y Geografía. (s. f.). *Población total por entidad federativa y grupo quinquenal de edad según sexo, serie de años censales de 1990 a 2020* [Tabulado interactivo]. Recuperado el 17 de noviembre de 2026, de https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_b0cd5bac-d8a2-4c83-95d5-7e3b97518d1e

## 15. Registro de modificaciones

| Versión | Fecha | Cambio |
|---|---|---|
| 1.0 | 2026-11-17 | Establecimiento inicial del protocolo para el Censo 2020 y la programación descriptiva en R. |

---

**Nota de atribución:** este documento constituye un protocolo del proyecto. La licencia del código original no modifica las condiciones de uso del tabulado del INEGI ni de las publicaciones académicas referenciadas.
