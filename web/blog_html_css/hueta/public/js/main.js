const container = document.querySelector('#posts-container');

document.addEventListener('DOMContentLoaded', async function () {
	try {
		const token = localStorage.getItem('access_token');
		axios.defaults.headers.common['Authorization'] = `${token}`;
		const headers = {
			'Authorization': `${token}`
		};
		await axios.get('/api/user/protected-route', { headers })
			.then(async () => {
				try {
					const response2 = await axios.get('/api/posts');
					let html = '';
					for (let i = response2.data.length - 1; i >= 0; i--) {
						const post = response2.data[i];
						const postHTML = await generatePostHTML(post);
						html = html + postHTML;
					}
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
});

async function generatePostHTML(post) {
	const response1 = await axios.get(`/api/userpost?id=${post.user_id}`);
	const photo = response1.data.photo ? '../../' + response1.data.photo.toString() : '../img/default.jpg';
	const isCurrentUserPost = post.user_id === getCurrentUserId();
	const editDeleteButtonsHTML = isCurrentUserPost ? `
		<div id="edit">
			<div class="edit-post">Редактировать</div>
			<div class="delete-post">Удалить</div>
		</div>
	` : '';
	const postElement = document.createElement('div');
	postElement.classList.add('post', 'styleshadow');
	postElement.dataset.id = post.id;
	// const photopost = post.image ? `` : '';
	postElement.innerHTML = `
		<div class="block-post">
			<div class="header-post">
				<div class="profile">
					<img class="ava-for-post" src="${photo}" alt="ava ">
					<label id="name-profile-post">${response1.data.name}</label>
				</div>
				<div class="date">
					<label id="date-create-post">${post.date}</label>
				</div>
			</div>
			<div class="content-post ">
				<div class="title"><label id="title-this-post">${post.title}</label></div>
				<div><img id="img-this-post" src="${post.image}"></div>
				<div class="text "><label id="text-this-post">${post.content.replace(/\n/g, '<br>')}</label></div>
			</div>
		</div>
		${editDeleteButtonsHTML}
	`;
	postElement.dataset.id = post.id;
	return postElement.outerHTML;
}


async function editPost(postId) {
	const response = await axios.get(`/api/post/${postId}`);
	const post = response.data;
	const formElement = document.createElement('form');
	formElement.id = 'form-editpost';
	formElement.innerHTML = `
	  <div class="block-new-post-content">
		<div class="title-new-post">
		  <textarea id="title-post" name="title" placeholder="Название поста" required style="height: auto">${post.title}</textarea>
		</div>
		<div class="add-image">
		  <img src="${post.image}" id="image-post">
		  <label id="image-post-lbl">${post.image ? '' : 'Тут картинка поста'}</label>
		</div>
		<div id="myTextarea" class="text-new-post">
		  <textarea id="text-post" name="content" placeholder="Текст поста" required style="height: auto">${post.content}</textarea>
		</div>
	  </div>
	  <div class="button-add-post">
		<button id="btn-add-image">Изменить картинку</button>
		<button id="btn-del-image">Удалить картинку(((</button>
		<button id="btn-save">Сохранить</button>
	  </div>
	`;
	return formElement.outerHTML;
}

function getCurrentUserId() {
	const token = localStorage.getItem('access_token');
	if (!token) {
		return null;
	}
	const [, payload] = token.split('.');
	const decodedPayload = JSON.parse(atob(payload));
	// console.log(decodedPayload)
	return decodedPayload.id;
}
let selectedFile;
container.addEventListener('click', async function (event) {
	event.preventDefault()

	const target = event.target;
	const postElement = target.closest('.post');
	const postId = postElement.dataset.id;
	const imagePostLbl = postElement.querySelector('#image-post-lbl');
	const imagePost = postElement.querySelector('#image-post');

	const input = document.createElement('input');
	input.type = 'file';
	input.accept = 'image/*';

	const formData = new FormData();
	if (target.id === 'btn-add-image') {
		input.click();
		input.addEventListener('change', function (event) {
			event.preventDefault();
			selectedFile = event.target.files[0];
			imagePostLbl.classList.add('hidden');
			if (selectedFile) {
				const reader = new FileReader();
				reader.onload = function () {
					imagePost.src = reader.result;
					const imageUrl = URL.createObjectURL(selectedFile);
					imagePost.setAttribute('src', imageUrl);
				};
				if (selectedFile.type.startsWith('image/')) {
					formData.append('image', selectedFile);
				}
				reader.readAsDataURL(selectedFile);
			}
		});
		postElement.appendChild(input);
	}
	if (target.id === 'btn-del-image') {
		try {
		  const response = await axios.patch(`/api/post/${postId}`);
		  imagePost.setAttribute('src', ''); // Очищаем атрибут src изображения
		  imagePostLbl.classList.remove('hidden'); // Показываем надпись "Тут картинка поста"
		} catch (error) {
		  console.error(error);
		}
	  }
	if (target.id === 'btn-save') {
		input.value = '';
		const title = postElement.querySelector('#title-post').value;
		const content = postElement.querySelector('#text-post').value;

		if (!title || !content) {
			alert('Пожалуйста, заполните все обязательные поля - название и текст поста');
			return;
		}
		try {
			const token = localStorage.getItem('access_token');
			axios.defaults.headers.common['Authorization'] = `${token}`;
			const headers = {
				'Authorization': `${token}`
			};

			formData.append('title', title);
			if (selectedFile && selectedFile.type.startsWith('image/')) {
				formData.append('image', selectedFile, selectedFile.name);
			}
			formData.append('content', content);
			formData.append('id', postId);
			const response = await axios.put(`/api/post`, formData, { headers });
			console.log(formData)
			const updatedPost = response.data;
			const updatedPostElement = document.querySelector(`.post[data-id="${updatedPost.id}"]`);
			updatedPostElement.outerHTML = await generatePostHTML(updatedPost);
		} catch (error) {
			console.error(error);
		}
	}
	if (target.classList.contains('delete-post')) {
		try {
			const response = await axios.delete(`/api/posts/${postId}`);
			postElement.parentNode.removeChild(postElement);
		} catch (error) {
			console.error(error);
		}
	}
	if (target.classList.contains('edit-post')) {
		const editFormHTML = await editPost(postId);
		postElement.innerHTML = editFormHTML;
	}
});

