const { uniqRow } = require('../lib/pg.js');

async function setMockdata() {
    const users = await uniqRow('select * from users;');
    if (!users) {
        console.log('PLEASE CHECK YOUR DATABASE ❗️');
    } else if (!users.rows.length) {
        const queryCreateUser = `
        insert into users (user_firstname, user_lastname, user_email, user_password, user_role) values 
        ('John', 'doe', 'johndoe@gmail.com', '12345678', 'suppermupper'),
        ('Fayzulloh', 'shodiyev', 'fayzullohwork@gmail.com', '6661114f', 'admin'),
        ('Falonchi', 'pistonchiyev', 'falonchi777@gmail.com', 'birnima13', 'staff')`
        await uniqRow(queryCreateUser);
        console.log('ADD MOCK DATAS TO DATABASE ✅');
    }
}

module.exports = setMockdata;
