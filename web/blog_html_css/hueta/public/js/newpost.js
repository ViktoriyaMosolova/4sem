const token = localStorage.getItem('access_token');
const headers = {
	'Authorization': `${token}`
};
axios.defaults.headers.common['Authorization'] = `${token}`;

const container = document.querySelector('#newpost-container');

document.addEventListener('DOMContentLoaded', async function () {
	try {
		const token = localStorage.getItem('access_token');
		axios.defaults.headers.common['Authorization'] = `${token}`;
		const headers = {
			'Authorization': `${token}`
		};
		await axios.get('/newpost', { headers })
		await axios.get('/api/user/protected-route', { headers })
			.then(async () => {
				try {
					let html = '';
					html += `
					<form id="form-newpost-create" class="block-new-post styleshadow">
						<div class="block-new-post-content">
							<div class="title-new-post"><textarea id="title-post" placeholder="Название поста" required></textarea></div>
							<div class="add-image"><image src="" alt="" id="image-post"><label id="image-post-lbl">Тут картинка поста</label></image></div>
							<div id="myTextarea" class="text-new-post"><textarea id="text-post" placeholder="Текст поста" required></textarea></div>
						</div>
						<div class="button-add-post">
							<button id="btn-add-image" >Добавить картинку</button>
							<button id="btn-public" >Опубликовать</button>
						</div>
					</form>
					`;
					// console.log(response1.data);
					container.innerHTML = html;
				} catch (error) {
					console.error(error);
				}
			})
			.catch(error => {
				localStorage.removeItem('access_token')
				document.location.href = '/login';
			});
	} catch (error) {
		console.error(error);
	}

	const textarea = document.querySelector('#text-post');

	textarea.addEventListener('input', function () {
		this.style.height = 'auto';
		this.style.height = (this.scrollHeight) + 'px';
	});

	const titleTextarea = document.querySelector('#title-post');
	const titleLimit = 105; // максимальное количество символов в title

	// автоматическое изменение высоты textarea
	titleTextarea.addEventListener('input', function () {
		this.style.height = 'auto';
		this.style.height = (this.scrollHeight) + 'px';
	});

	// ограничение количества символов в title
	titleTextarea.addEventListener('input', function () {
		const titleLength = this.value.length;
		if (titleLength > titleLimit) {
			this.value = this.value.slice(0, titleLimit);
			alert(`Максимальное количество символов - ${titleLimit}`);
		}
	});

	const form = document.querySelector('#form-newpost-create');
	const imagePost = form.querySelector('#image-post');
	const lbl = form.querySelector('#image-post-lbl');

	const input = document.createElement('input');
	input.type = 'file';
	input.accept = 'image/*';

	// Добавление обработчика событий для кнопки "Добавить картинку"
	form.querySelector('#btn-add-image').addEventListener('click', function (event) {
		event.preventDefault();

		// Добавление обработчика событий для выбора файла
		input.addEventListener('change', function () {
			const file = this.files[0];
			lbl.classList.add('hidden')
			// Проверка, что выбран файл и он имеет тип "image"
			if (file && file.type.startsWith('image/')) {
				const reader = new FileReader();

				// Обработка загруженного изображения
				reader.onload = function () {
					imagePost.src = reader.result;
					const imageUrl = URL.createObjectURL(file);
					imagePost.setAttribute('src', imageUrl);
					// console.log(imageUrl)
				}
				reader.readAsDataURL(file);
			}
		});
		input.click();
	});


	form.querySelector('#btn-public').addEventListener('click', async function (event) {
		event.preventDefault();
		const title = document.querySelector('#title-post').value;
		const text = document.querySelector('#text-post').value;
	
		if (!title || !text) {
			alert('Пожалуйста, заполните все обязательные поля - название и текст поста');
			return;
		}

		const formData = new FormData();
		formData.append('title', document.querySelector('#title-post').value);
		formData.append('content', document.querySelector('#text-post').value);

		const file = input.files[0];
		// console.log(file)
		if (file && file.type.startsWith('image/')) {
			formData.append('image', file);
		}

		try {
			const res = await axios.get('/api/user', { headers });
			formData.append('userId', res.data.id);

			const response = await axios.post('/api/post', formData, { headers });
			console.log(response)
			// container.innerHTML = '<h2>Пост успешно создан!</h2>';
			document.location.href = '/main';
		} catch (error) {
			console.error(error);
		}
	});
});