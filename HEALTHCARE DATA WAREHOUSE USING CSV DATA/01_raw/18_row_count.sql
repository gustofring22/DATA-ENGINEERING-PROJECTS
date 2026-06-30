SELECT
    table_name,
    (xpath('/row/cnt/text()',
        query_to_xml(
            'SELECT COUNT(*) AS cnt FROM raw.' || quote_ident(table_name),
            false, true, ''
        )
    ))[1]::TEXT::INT AS row_count
FROM information_schema.tables
WHERE table_schema = 'raw'
ORDER BY table_name;