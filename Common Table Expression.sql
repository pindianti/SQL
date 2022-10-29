/*Common Table Expression (CTE) adalah salah satu bentuk query SQL yang digunakan untuk menyederhanakan JOIN pada SQL kedalam subqueries*/
/*Serta mampu memberikan query yang bersifat hieararki*/
/*pengen nampilin gabungan dari pertanyaan dan jawaban dengan key pertanyaan.id=answer.question_id*/
with CTE as(
    select question_text,
        (select count(*) from answer A where A.question_id=Q.id) AS number_of_answers
        from questions Q
)
select*from CTE
where number_of_answers

/*dari output sebelumnya, jawabannya pengen dikelompokkan dengan pertanyaan dalam hasil*/
with CTE as(
    select [quiz_id]
    ,[id] as question_id
    ,null as answer_id
        ,[question_text]
        ,null as answer
        ,1 as is_question
    from [questions]

    union all

    select Q[quiz_id]
        ,[question_id]
        ,A.[id] ad answer_id
        ,Q.question_text
            ,[answer]
            ,0 as is_question
            from [answer] A inner join [questions] Q on Q.quiz_id = A.quiz_id and Q.id = A.question_id
    
)
select 
    quiz_id,
    question_id,
    is_question,
    (case when answer is null then question_text else answer end) as name
from CTE 
group by quiz_id, question_id, answer_id, question_text, answer, is_question
order by quiz_id, question_id, is_question desc, name
/*source: https://www.pengembangan-web-mp-pd.com/id/sql/kapan-menggunakan-common-table-expression-cte/971947552/*/
