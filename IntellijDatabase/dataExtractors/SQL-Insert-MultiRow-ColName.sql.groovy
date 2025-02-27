/*
 * Available context bindings:
 *   COLUMNS     List<DataColumn>
 *   ROWS        Iterable<DataRow>
 *   OUT         { append() }
 *   FORMATTER   { format(row, col); formatValue(Object, col); getTypeName(Object, col); isStringLiteral(Object, col); }
 *   TRANSPOSED  Boolean
 * plus ALL_COLUMNS, TABLE, DIALECT
 *
 * where:
 *   DataRow     { rowNumber(); first(); last(); data(): List<Object>; value(column): Object }
 *   DataColumn  { columnNumber(), name() }
 */

SEP = ", "
QUOTE     = "\'"
STRING_PREFIX = DIALECT.getDbms().isMicrosoft() ? "N" : ""
NEWLINE   = System.getProperty("line.separator")

KEYWORDS_LOWERCASE = com.intellij.database.util.DbSqlUtil.areKeywordsLowerCase(PROJECT)
KW_INSERT_INTO = KEYWORDS_LOWERCASE ? "insert into " : "INSERT INTO "
KW_VALUES = KEYWORDS_LOWERCASE ? "values" : "VALUES"
KW_NULL = KEYWORDS_LOWERCASE ? "null" : "NULL"

begin = true
showColumnName = true

def record(columns, dataRow) {

    if (begin) {
        OUT.append(KW_INSERT_INTO)
        if (TABLE == null) OUT.append("MY_TABLE")
        else OUT.append(TABLE.getName())
        OUT.append(" (")

        columns.eachWithIndex { column, idx ->
            OUT.append(column.name()).append(idx != columns.size() - 1 ? SEP : "")
        }

        OUT.append(")").append(NEWLINE)
        OUT.append(KW_VALUES).append("  (")
        begin = false
    }
    else {
        OUT.append(",").append(NEWLINE)
        OUT.append("        (")
    }

    columns.eachWithIndex { column, idx ->
        def value = dataRow.value(column)
        def stringValue = value == null ? KW_NULL : FORMATTER.formatValue(value, column)
        def isStringLiteral = value != null && FORMATTER.isStringLiteral(value, column)
        if (isStringLiteral && DIALECT.getDbms().isMysql()) stringValue = stringValue.replace("\\", "\\\\")
        if (showColumnName) {
			OUT.append("/*").append(column.name()).append("*/ ")
		}
        OUT.append(isStringLiteral ? (STRING_PREFIX + QUOTE) : "")
          .append(stringValue ? stringValue.replace(QUOTE, QUOTE + QUOTE) : stringValue)
          .append(isStringLiteral ? QUOTE : "")
          .append(idx != columns.size() - 1 ? SEP : "")
    }
    OUT.append(")")
}

ROWS.each { row -> record(COLUMNS, row) }
OUT.append(";")
