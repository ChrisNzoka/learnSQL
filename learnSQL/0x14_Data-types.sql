# String Data Types
CHAR(size)	FIXED length string of chars. Size from 0 to 255. Default 1.
VARCHAR(size) VARIABLE length string of chars. Size from 0 to 65535.
BINARY(size) Equal to CHAR(), but stores binary byte strings. Default 1.
VARBINARY(size)	Equal to VARCHAR(), but stores binary byte strings.
TINYBLOB	For BLOBs (Binary Large OBjects). Max length: 255 bytes
TINYTEXT	Holds a string with a maximum length of 255 characters
TEXT(size)	Holds a string with a maximum length of 65,535 bytes
BLOB(size)	For BLOBs. Holds up to 65,535 bytes of data
MEDIUMTEXT	Holds a string with maximum length of 16,777,215 characters
MEDIUMBLOB	For BLOBs. Holds up to 16,777,215 bytes of data
LONGTEXT	Holds string with maximum length of 4,294,967,295 characters
LONGBLOB	For BLOBs. Holds up to 4,294,967,295 bytes of data
ENUM(val1, val2, ...) String object of one or more values. Up to 65535 values.
SET(val1, val2, ...) String object of 0 or more values. Up to 64 values.

### Numeric Data Types
BIT(size)	A bit-value type. Size from 1 to 64. Default is 1.
TINYINT(size) Very small integer. Signed (-128, 127). Unsigned (0, 255).
BOOL	Zero is considered false, nonzero values are considered true.
BOOLEAN	Equal to BOOL
SMALLINT(size) Small integer. Signed (-32768, 32767). Unsigned (0, 65535). 
MEDIUMINT(size)	 Medium integer. Signed (-8388608, 8388607). Unsigned (0, 16777215).
INT(size)  Medium integer. Signed (-2147483648, 2147483647) Unsigned (0, 4294967295). 
INTEGER(size)	Equal to INT(size)
BIGINT(size)  Large integer. Signed (-9223372036854775808, 9223372036854775807). Unsigned (0, 18446744073709551615).
FLOAT(size, d)	Floating point number. Digits after decimal defined by d.
FLOAT(p) Floating point number. p chooses FLOAT(0, 24) or DOUBLE(25, 53).
DOUBLE(size, d)	Normal-size floating point. Digits after "," defined by d.
DOUBLE PRECISION(size, d)	 
DECIMAL(size, d) Exact fixed-point number.
DEC(size, d)	Equal to DECIMAL(size,d)
NUMERIC -- Another type of float 

### Date and Time Data Types
DATE	A date. Format: YYYY-MM-DD. Range: ('1000-01-01' to '9999-12-31')
DATETIME(fsp)  Date and time. Format: YYYY-MM-DD hh:mm:ss. Range: ('1000-01-01 00:00:00' to '9999-12-31 23:59:59').
TIMESTAMP(fsp)  Seconds since Unix epoch ('1970-01-01 00:00:00' UTC). Format: YYYY-MM-DD hh:mm:ss. Range('1970-01-01 00:00:01' UTC to '2038-01-09 03:14:07' UTC).
TIME(fsp)   Time. Format: hh:mm:ss. Range: ('-838:59:59' to '838:59:59')
YEAR            Year in four-digit format. Range (1901 to 2155)