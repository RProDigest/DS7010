# ============================================================
# Base Station Data Dictionary Table
# APA-friendly Word export using flextable + officer
# Source: Zindi (2023)
# ============================================================

# Install packages if needed
# install.packages(c("dplyr", "tibble", "flextable", "officer"))

library(dplyr)
library(tibble)
library(flextable)
library(officer)

# ------------------------------------------------------------
# 1. Create the data dictionary table
# ------------------------------------------------------------

bs_dictionary <- tribble(
  ~Label,      ~Description,
  "BS",        "Name of the base station",
  "CellName",  "Name of the cell",
  "RUType",    "Name of the radio unit type",
  "Mode",      "Transmission mode",
  "Frequency", "Frequency of the cell",
  "Bandwidth", "Bandwidth of the cell",
  "Antennas",  "Number of antennas of the base station",
  "TXpower",   "Maximum transmit power of the cell"
)

# ------------------------------------------------------------
# 2. Format the table for Word
# ------------------------------------------------------------

bs_dictionary_flex <- flextable(bs_dictionary) %>%
  theme_booktabs() %>%
  font(fontname = "Times New Roman", part = "all") %>%
  fontsize(size = 12, part = "all") %>%
  bold(part = "header") %>%
  align(align = "left", part = "all") %>%
  valign(valign = "top", part = "all") %>%
  width(j = "Label", width = 1.4) %>%
  width(j = "Description", width = 4.8) %>%
  padding(padding.top = 6, padding.bottom = 6, part = "all") %>%
  autofit()

# ------------------------------------------------------------
# 3. Create the Word document
# ------------------------------------------------------------

doc <- read_docx() %>%
  body_add_par("Table X", style = "Normal") %>%
  body_add_par("Base Station Data Dictionary", style = "Normal") %>%
  body_add_flextable(bs_dictionary_flex) %>%
  body_add_par(
    "Note. The table summarises the variables contained in the base station information dataset. Source: Zindi (2023).",
    style = "Normal"
  )

# ------------------------------------------------------------
# 4. Export to Word
# ------------------------------------------------------------

print(doc, target = "bs_dictionary_table.docx")
