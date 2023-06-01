-- MIT License
--
-- Copyright (c) 2023 Gerald Venzl
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- Creates a view "ALL_DB_PRIVILEGES" that will return all available
-- privileges in Oracle Database.
-- TYPE:
--    OBJECT: Privileges on objects, i.e. GRANT ... ON <object> TO <user>/<role>;
--    SYSTEM: System privilege, i.e. GRANT ... TO <user>/<role>;
--    USER: Privileges on users, i.e. GRANT ... ON USER <user> TO <user>/<role>'

CREATE OR REPLACE VIEW all_db_privileges (type, name, grantability) AS
  SELECT
      'OBJECT' AS type,
      name,
      'SQL GRANT statement' AS grantability
    FROM sys.table_privilege_map
  UNION ALL
  SELECT
      'SYSTEM' AS type,
      name,
      CASE
        WHEN property = 0 THEN 'SQL GRANT statement'
        WHEN property = 1 THEN 'PL/SQL package'
        ELSE 'Unknown'
      END AS grantability
  FROM sys.system_privilege_map
  UNION ALL
  SELECT
      'USER' AS type,
      name,
      'SQL GRANT statement' AS grantability
    FROM sys.user_privilege_map;
