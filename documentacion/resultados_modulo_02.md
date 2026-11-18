# Módulo 02. Distribuciones de frecuencias

## Proyecto: Estructura demográfica de México

- **Autor:** Aldo Rodríguez Lechuga
- **Lenguaje de programación:** R
- **Fuente:** Censo de Población y Vivienda 2020, INEGI
- **Alcance:** Nacional y estatal
- **Enfoque metodológico:** Estadística descriptiva
- **Estado:** Completado y validado

---

## 1. Introducción

El estudio de la estructura demográfica constituye un componente
fundamental del análisis económico, social y territorial de México.
La distribución de la población por edad, sexo y entidad federativa
permite identificar características relevantes para la planificación
económica, la provisión de servicios públicos y el diseño de
políticas públicas.

Tuirán (2002, p. 25) señala que la transición demográfica mexicana
se relaciona con transformaciones en las trayectorias individuales
y familiares, así como con cambios en la organización social.

Por su parte, Sobrino (2024) examina las modificaciones de la
dinámica demográfica y la distribución territorial de la población
mexicana entre 1990 y 2020, destacando la importancia de los
procesos de concentración poblacional y urbanización.

El presente módulo desarrolla un análisis estadístico descriptivo
de la población mexicana mediante distribuciones de frecuencias
univariadas y bivariadas.

---

## 2. Objetivo general

Analizar la distribución de la población mexicana por sexo,
grupo de edad y entidad federativa mediante frecuencias
absolutas, relativas, porcentuales, acumuladas, conjuntas,
marginales y condicionales.

### 2.1. Objetivos específicos

- Examinar la distribución nacional de la población por sexo.
- Describir la estructura demográfica por grupos de edad.
- Construir tablas de contingencia.
- Analizar la distribución territorial de la población.
- Identificar diferencias demográficas entre entidades federativas.
- Garantizar la consistencia estadística de los resultados.
- Generar archivos reproducibles e interoperables.

---

## 3. Fuente y cobertura estadística

La información proviene del Instituto Nacional de Estadística
y Geografía (INEGI), específicamente del Censo de Población
y Vivienda 2020.

Se utiliza el tabulado oficial denominado:

**Población total por entidad federativa y grupo quinquenal
de edad según sexo, serie de años censales de 1990 a 2020.**

El análisis se restringe al año censal 2020.

| Característica | Descripción |
|---|---|
| Año de referencia | 2020 |
| Población nacional | 126,014,024 |
| Entidades federativas | 32 |
| Agregado nacional | 1 |
| Grupos de edad especificada | 21 |
| Categorías de edad no especificada | 1 |
| Registros de la base validada | 759 |
| Variables | 5 |

La base contiene información agregada, no microdatos individuales.

---

## 4. Fundamento estadístico

Illowsky y Dean (2023, pp. 27–28) desarrollan las distribuciones
de frecuencias como instrumentos para organizar y resumir
información estadística.

### 4.1. Frecuencia absoluta

Representa el número de observaciones correspondientes
a una determinada categoría.

$$
n_i
$$

### 4.2. Frecuencia relativa

Expresa la participación de cada categoría respecto
al total de observaciones.

$$
f_i=\frac{n_i}{N}
$$

### 4.3. Frecuencia porcentual

Expresa la frecuencia relativa en términos porcentuales.

$$
p_i=\frac{n_i}{N}\times100
$$

### 4.4. Frecuencia absoluta acumulada

Representa la suma progresiva de las frecuencias absolutas.

$$
F_i=\sum_{k=1}^{i}n_k
$$

### 4.5. Frecuencia relativa acumulada

$$
H_i=\sum_{k=1}^{i}f_k
$$

### 4.6. Frecuencia porcentual acumulada

$$
P_i=\sum_{k=1}^{i}p_k
$$

Las frecuencias acumuladas se aplican únicamente a los grupos
de edad especificada, debido a su orden natural.

### 4.7. Frecuencias conjuntas

Las tablas de contingencia permiten organizar simultáneamente
las categorías de dos variables (Illowsky y Dean, 2023,
pp. 183–184).

$$
f_{ij}=\frac{n_{ij}}{N}
$$

### 4.8. Frecuencias marginales

Las frecuencias marginales corresponden a las sumas
de las frecuencias conjuntas por filas y columnas.

$$
n_{i\cdot}=\sum_j n_{ij}
$$

$$
n_{\cdot j}=\sum_i n_{ij}
$$

### 4.9. Frecuencias condicionales

Distribución condicionada por filas:

$$
f_{j|i}=\frac{n_{ij}}{n_{i\cdot}}
$$

Distribución condicionada por columnas:

$$
f_{i|j}=\frac{n_{ij}}{n_{\cdot j}}
$$

---

## 5. Resultados estadísticos

### 5.1. Distribución nacional por sexo

| Sexo | Frecuencia absoluta | Participación (%) |
|---|---:|---:|
| Hombres | 61,473,390 | 48.7830 |
| Mujeres | 64,540,634 | 51.2170 |
| Total | 126,014,024 | 100.0000 |

Los resultados muestran una mayor participación femenina
en la composición demográfica nacional.

### 5.2. Cobertura de la información por edad

| Categoría | Población | Participación (%) |
|---|---:|---:|
| Edad especificada | 125,740,638 | 99.7831 |
| Edad no especificada | 273,386 | 0.2169 |
| Total | 126,014,024 | 100.0000 |

La categoría de edad no especificada se conserva en las
distribuciones conjuntas y condicionales.

Sin embargo, se excluye del cálculo de las frecuencias
acumuladas por carecer de una posición cronológica definida.

### 5.3. Distribución nacional por edad

Entre la población con edad especificada:

- El 25.2546 % tenía menos de 15 años.
- El 50.0849 % tenía menos de 30 años.
- El 8.2089 % tenía 65 años o más.
- El grupo de 10 a 14 años registró la mayor frecuencia
  absoluta, con 10,943,540 habitantes.

Estos resultados describen la composición etaria de México
en el año censal 2020.

### 5.4. Distribución condicional por edad y sexo

| Grupo de edad | Hombres (%) | Mujeres (%) |
|---|---:|---:|
| 0 a 4 años | 50.5355 | 49.4645 |
| 15 a 19 años | 50.5442 | 49.4558 |
| 20 a 24 años | 49.5667 | 50.4333 |
| 65 a 69 años | 46.8262 | 53.1738 |
| 80 a 84 años | 44.5659 | 55.4341 |
| 100 años y más | 36.3159 | 63.6841 |

Se identifica un predominio femenino a partir del grupo
de 20 a 24 años, particularmente pronunciado en los grupos
de edades más avanzadas.

### 5.5. Distribución territorial de la población

| Posición | Entidad federativa | Población | Participación (%) |
|---:|---|---:|---:|
| 1 | Estado de México | 16,992,418 | 13.4845 |
| 2 | Ciudad de México | 9,209,944 | 7.3087 |
| 3 | Jalisco | 8,348,151 | 6.6248 |
| 4 | Veracruz | 8,062,579 | 6.3982 |
| 5 | Puebla | 6,583,278 | 5.2242 |

Las cinco entidades federativas más pobladas concentran
el 39.0404 % de la población nacional.

### 5.6. Distribución por entidad federativa y sexo

| Entidad | Hombres (%) | Mujeres (%) |
|---|---:|---:|
| Aguascalientes | 48.8692 | 51.1308 |
| Puebla | 48.0022 | 51.9978 |
| Baja California Sur | 50.8336 | 49.1664 |

La composición de la población por sexo presenta
diferencias entre entidades federativas.

### 5.7. Aplicación territorial: Puebla

| Grupo de edad | Población | Participación estatal (%) |
|---|---:|---:|
| 0 a 4 años | 578,779 | 8.7917 |
| 5 a 9 años | 598,550 | 9.0920 |
| 10 a 14 años | 603,375 | 9.1653 |
| 15 a 19 años | 607,200 | 9.2234 |
| 20 a 24 años | 570,646 | 8.6681 |

La población menor de 15 años representa el 27.0489 %
de la población total de Puebla, frente al 25.1998 %
de la población nacional total.

---

## 6. Relevancia para las ciencias sociales

### 6.1. Economía

La estructura demográfica constituye un insumo para
examinar la oferta potencial de trabajo, el consumo,
la dependencia demográfica y las necesidades de
financiamiento de la seguridad social.

### 6.2. Ciencia política

La distribución territorial y etaria de la población
proporciona información descriptiva relevante para
estudiar las relaciones entre población, representación
política y organización territorial del Estado.

### 6.3. Políticas públicas

La información demográfica permite contextualizar
las necesidades diferenciadas de educación, salud,
vivienda, infraestructura y protección social.

### 6.4. Economía política

La estructura poblacional proporciona una base para
examinar las relaciones entre cambio demográfico,
distribución de recursos, capacidades institucionales
y organización económica.

---

## 7. Validación estadística

| Componente | Comprobaciones | Resultado |
|---|---:|---|
| Distribución por sexo | 3 | Aprobado |
| Distribución por edad | 6 | Aprobado |
| Distribución conjunta por edad y sexo | 8 | Aprobado |
| Distribuciones condicionales | 9 | Aprobado |
| Distribución territorial | 8 | Aprobado |
| Distribución por entidad y sexo | 11 | Aprobado |
| Distribución por entidad y edad | 11 | Aprobado |
| Total | 56 | Aprobado |

La totalidad de las comprobaciones estadísticas
devolvió el valor lógico TRUE.

---

## 8. Reproducibilidad

El procesamiento se realiza mediante el script:

`codigo/02_distribuciones_frecuencias.R`

La base de entrada corresponde al archivo:

`datos/procesados/poblacion_mexico_2020_validada.rds`

Para reproducir el módulo, ejecutar desde el directorio
principal del proyecto:

`source("codigo/02_distribuciones_frecuencias.R")`

Los resultados se almacenan en:

`resultados/tablas/modulo_02/`

| Formato | Archivos | Integridad |
|---|---:|---|
| CSV | 21 | Verificada |
| RDS | 1 | Verificada |
| Total | 22 | Verificada |

Se conserva la precisión numérica de los cálculos.
El redondeo a cuatro decimales se utiliza exclusivamente
para la presentación de resultados.

---

## 9. Limitaciones metodológicas

- El análisis corresponde exclusivamente al año 2020.
- Se utilizan datos censales agregados.
- No se establecen relaciones causales.
- No se realizan inferencias temporales sobre el
  envejecimiento poblacional.
- La información de edad no especificada se mantiene
  identificada.
- Las frecuencias estatales no representan medidas
  de densidad poblacional.
- Los resultados no sustituyen indicadores específicos
  de empleo, ingreso, salud o bienestar.

---

## 10. Conclusiones

El módulo permite caracterizar la distribución de la
población mexicana por sexo, edad y entidad federativa,
identificando diferencias en su composición demográfica.

Las distribuciones conjuntas y condicionales amplían
las posibilidades del análisis descriptivo y constituyen
una base para la construcción posterior de indicadores
demográficos.

La consistencia interna de los resultados se comprobó
mediante 56 validaciones estadísticas, complementadas
con la verificación de los archivos exportados.

---

## 11. Referencias bibliográficas

Illowsky, B., y Dean, S. (2023). *Introductory statistics*
(2.ª ed.). OpenStax.
https://openstax.org/details/books/introductory-statistics-2e

Instituto Nacional de Estadística y Geografía. (2021).
*Censo de Población y Vivienda 2020*.
https://www.inegi.org.mx/programas/ccpv/2020/

Instituto Nacional de Estadística y Geografía. (s. f.).
*Población total por entidad federativa y grupo quinquenal
de edad según sexo, serie de años censales de 1990 a 2020*
[Tabulado estadístico].
https://www.inegi.org.mx/app/tabulados/interactivos/?pxq=Poblacion_Poblacion_01_e60cd8cf-927f-4b94-823e-972457a12d4b

Sobrino, J. (2024). Dinámica demográfica, forma urbana y
densidad de población en ciudades de México, 1990-2020:
¿urbanización compacta o dispersa? *Estudios Demográficos
y Urbanos, 39*(2), 1–31.
https://doi.org/10.24201/edu.v39i2.2190

Tuirán, R. (2002). Transición demográfica, trayectorias
de vida y desigualdad social en México: lecciones
y opciones. *Papeles de Población, 8*(31), 25–66.
https://www.redalyc.org/pdf/112/11203102.pdf
